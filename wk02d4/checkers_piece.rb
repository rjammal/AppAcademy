# encoding: utf-8

require './checkers_board.rb'
require 'colorize'

class OffBoardException < Exception
end

class InvalidMoveError < StandardError
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

  def perform_moves!(move_arr)
    move_arr.each do |move|
      fail_string = "Cannot move from #{x}, #{y} to #{move_arr[0]}, #{move_arr[1]}."
      if move_arr.length > 1
        unless perform_jump(*move)
          raise InvalidMoveError.new fail_string
        end
      else
        unless perform_jump(*move) || perform_slide(*move)
          raise InvalidMoveError.new fail_string
        end
      end
    end
  end

  def valid_move_seq?(move_arr)
    board_dup = board.dup
    piece_copy = board_dup[x, y]
    begin
      piece_copy.perform_moves!(move_arr)
    rescue InvalidMoveError
      return false
    end
    true
  end

  def perform_moves(move_arr)
    if valid_move_seq?(move_arr)
      perform_moves!(move_arr)
    else
      raise InvalidMoveError.new "That is an invalid sequence of moves."
    end
  end

  def maybe_promote
    if y == BACK_ROW[color]
      @king = true
    end
  end

  def dup(new_board)
    CheckersPiece.new(x, y, color, new_board, king)
  end

  def to_s
    king_symbols = {red: "✪".red, black: "✪".white}
    piece_symbols = {red: "●".red, black: "◯".white}
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