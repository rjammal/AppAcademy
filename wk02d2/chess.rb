# encoding: utf-8
require './board.rb'
class Piece
  attr_accessor :x, :y
  attr_reader :color, :board
  
  def initialize(color, board, x, y)
    @color = color
    @board = board
    @x, @y = x, y
  end
  
  def move(new_x, new_y)
    unless valid_move?(new_x, new_y)
      raise ArgumentError.new "Those are not valid coordinates."
    end
    board[x, y] = nil
    @x, @y = new_x, new_y
    
    board[new_x, new_y] = self
  end
  
  def valid_move?(x, y)
    (0...8).include?(x) && (0...8).include?(y)
  end
  
  def moves
    raise NoMethodError.new "Called Piece SuperClass 'moves' method"
  end
  
  def dup(boardcopy)
    self.class.new(color, boardcopy, x, y)
  end
  
  def to_s
    black_hash = {king: "♚",queen: "♛", rook: "♜", bishop: "♝", knight: "♞", pawn: "♟"}
    white_hash = {king: "♔",queen: "♕", rook: "♖", bishop: "♗", knight: "♘", pawn: "♙"}
    
    if color == :black
      black_hash[self.class.to_s.downcase.to_sym]
    elsif color == :white
      white_hash[self.class.to_s.downcase.to_sym]
    end
  end
end




class SteppingPiece < Piece
  
  def moves(deltas)
    
    results = []
    deltas.each do |delt|
      newx, newy = [x + delt[0], y + delt[1]]
      next unless valid_move?(newx, newy)
      destination_sq = board[newx, newy]
      occupied = destination_sq && destination_sq.color == self.color
      
      results << [newx, newy] unless occupied
      
    end
    results
    
  end
end

class SlidingPiece < Piece
  
    
  
  def moves(orthogonal = false, diagonal = false)
    results = []
    deltas = []
    if orthogonal
      deltas += [
        [ 0,  1],
        [ 0, -1],
        [ 1,  0],
        [-1,  0]
      ]
    end
    if diagonal
      deltas += [
        [ 1, -1], 
        [ 1,  1], 
        [-1, -1], 
        [-1,  1]
      ]
    end
   
    deltas.each do |movement|
      limit = [x + movement[0], y + movement[1]]
      while (0...8).include?(limit[0]) && (0...8).include?(limit[1])
        destination_sq = board[limit[0], limit[1]]
        if destination_sq
          if destination_sq.color != self.color
            capture_square = [limit[0], limit[1]]
            results << capture_square
          end
          break
        else
          results << [limit[0], limit[1]]
          limit[0] += movement[0]
          limit[1] += movement[1]
        end
      end
    end
  
    results
end
  
end

class Pawn < Piece
  attr_accessor :moved
  
  def initialize(color, board, x, y)
    @moved = false
    super
  end
  
  def moves
    results =[]
    directions = {black: 1, white: -1}
    vertical_movement = directions[color]
    if board[x, y + vertical_movement].nil?
      results << [x, y + vertical_movement]
      if !moved && board[x, y + (vertical_movement * 2)].nil?
        results << [x, y + (vertical_movement * 2)]
      end
    end
    [1 , -1].each do |side|
      if valid_move?(x + side, y + vertical_movement)
        square = board[x + side, y + vertical_movement] 
        if square && square.color != color
          results << [x + side, y + vertical_movement]
        end
      end
    end
    results
  end
  
  def move(new_x, new_y)
    super
    @moved = true
  end
end

class Knight < SteppingPiece
  
  def moves
    deltas = [
      [-2, -1],
      [-2,  1],
      [-1, -2],
      [-1,  2],
      [ 1, -2],
      [ 1,  2],
      [ 2, -1],
      [ 2,  1]
    ]
    super(deltas)
  end
end

class Rook < SlidingPiece
  def moves
    super(true, false) #true for orthogonal, false for diagonal 
  end
end

class Bishop < SlidingPiece
  def moves
    super(false, true)
  end 
end

class Queen < SlidingPiece
  def moves
    super(true, true) #true for orthogonal, true for diagonal 
  end
end

class King < SteppingPiece
  
  def moves
    deltas = (-1..1).to_a.product((-1..1).to_a).reject {|pair| pair == [0, 0]}
    super(deltas)
  end
  
end