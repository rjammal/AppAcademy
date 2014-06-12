require './checkers_board.rb'

class OffBoardException < Exception
end

class CheckersPiece

  BACK_ROW = {red: 0, black: 7}

  attr_accessor :x, :y, :king, :board
  attr_reader :color

  def initialize(x, y, color, board, king = false)
    @x, @y, @color, @board, @king = x, y, color, board, king
  end

  def perform_slide(new_x, new_y)
    if valid_slides.include?([new_x, new_y]) && board.empty?(new_x, new_y)
      board[x, y] = nil
      @x, @y = new_x, new_y
      board[x, y] = self
      maybe_promote
      true
    else
      false
    end
  end

  def perform_jump(new_x, new_y)
    if valid_jumps.include?([new_x, new_y])
      movement_vector = [(new_x - x) / 2, (new_y - y) / 2]
      board[x + movement_vector[0], y + movement_vector[1]] = nil
      
      board[x, y] = nil
      @x, @y = new_x, new_y
      board[new_x, new_y] = self
      maybe_promote
      true
    else
      false
    end
  end

  def maybe_promote
    if y == BACK_ROW[color]
      @king = true
    end
  end

  def to_s
    piece_symbols = {red: "r", black: "b"}
    king_symbols = {red: "R", black: "B"}
    if king
      king_symbols[color]
    else
      piece_symbols[color]
    end
  end



  def on_board?(x, y)
    (0..7).include?(x) && (0..7).include?(y)
  end

  def move_diffs
    directions = {
      red: [[-1, -1], [1, -1]], 
      black: [[-1, 1], [1, 1]]
    }
    if king
      directions[:red] + directions[:black]
    else
      directions[color]
    end
  end

  def valid_slides
    result = move_diffs.map do |diff| 
      [x + diff[0], y + diff[1]]
    end
    result.select { |move| on_board?(*move) }
  end

  def valid_jumps 
    result = []
    valid_slides.each do |slide|
      x_slide, y_slide = slide
      if board.empty?(x_slide, y_slide)
        next
      elsif board[x_slide, y_slide].color == color
        next
      end
      movement_vector = [(x_slide - x) * 2, (y_slide - y) * 2]
      destination_square = [x + movement_vector[0], y + movement_vector[1]]
      if board.empty?(*destination_square)
        result << destination_square
      end
    end

    result.select { |move| on_board?(*move) }
  end


end