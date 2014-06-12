require './checkers_piece.rb'
require 'colorize'

class CheckersBoard

  attr_accessor :grid

  def blank_grid
    Array.new(8) {Array.new(8)}
  end

  def initialize
    start_rows = {black: (0..2), red: (5..7)}
    @grid = blank_grid

    start_rows.each do |color, rows|
      rows.each do |y|
        8.times do |x|
          if (x + y).even?
            self[x, y] = CheckersPiece.new(x, y, color, self)
          end
        end
      end
    end
  end

  def [](x, y)
    @grid[y][x]
  end

  def []=(x, y, value)
    @grid[y][x] = value
  end

  def empty?(x, y)
    self[x, y].nil?
  end

  def dup
    b = CheckersBoard.new
    b.grid = blank_grid
    grid.flatten.compact.each do |piece|
      b[piece.x, piece.y] = piece.dup(b)
    end
    b
  end

  def get_pieces(color)
    grid.flatten.compact.select { |piece| piece.color == color }
  end


  def to_s
    result = "\n  1  2  3  4  5  6  7  8 \n"
    @grid.each_with_index do |row, y|
      result << (y + 1).to_s
      row.each_with_index do |tile, x|
        tile ||= " "
        if (x + y).even?
          result << " #{tile} ".on_black
        else
          result << " #{tile} ".on_red
        end
      end
      result << "#{y + 1}\n"
    end
    result + "  1  2  3  4  5  6  7  8 \n"
  end

end