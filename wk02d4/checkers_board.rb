require './checkers_piece.rb'
require 'colorize'

class CheckersBoard

  def initialize
    start_rows = {black: (0..2), red: (5..7)}
    @grid = Array.new(8) {Array.new(8)}

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

  def to_s
    result = "\n  0  1  2  3  4  5  6  7 \n"
    @grid.each_with_index do |row, y|
      result << y.to_s
      row.each do |tile|
        tile ||= " "
        result << " #{tile} "
      end
      result << "#{y}\n"
    end
    result + "  0  1  2  3  4  5  6  7 \n"
  end

end