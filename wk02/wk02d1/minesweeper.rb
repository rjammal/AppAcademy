#!/usr/bin/env ruby
# -*- coding: UTF-8 -*-

require 'debugger'
require 'time'
require 'yaml'

ROW = 30
class Tile
  VALUE_HASH = { 1 => "1️⃣", 
          2 => "2️⃣",
          3 => "3️⃣",
          4 => "4️⃣",
          5 => "5️⃣",
          6 => "6️⃣",
          7 => "7️⃣",
          8 => "8️⃣"}
  
  # it's position and the Grid, then the tile itself can find the neighbors.
  # #neighbors
  # #num_adjacent_bombs
  
  # Name: #num_adjacent_bombs
  attr_accessor :flag, :revealed, :mine, :adj_bombs, :cursor
  
  def initialize
    @flag = false
    @revealed = false
    @mine = false
    @adj_bombs = 0
    @cursor = false
  end
  
  def to_s
    result = ''
    if @flag 
      result = "🚩"
    elsif @revealed
      result = VALUE_HASH[@adj_bombs]
      result = "◻️" if @adj_bombs == 0
      result = "💣" if @mine
    else
      result = "◼️" 
    end
    return " " + result if @cursor
    result + " "
  end
end

class Board
  attr_accessor :rows
  def initialize(bombs)
    @rows = Array.new(ROW) {Array.new(ROW) {Tile.new} }
    until bombs == 0
      tile = @rows[rand(ROW)][rand(ROW)]
      next if tile.mine
      tile.mine = true
      bombs -= 1
    end
    @rows.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        tile.adj_bombs = neighbors_bomb_count(x, y)
      end
    end
  end
  
  # def []
  
  def neighbors(x, y)
    result = []
    result_check = ["+", "-"]
    num = [1,0]
    pairs = (-1..1).to_a.product((-1..1).to_a)
    pairs = pairs.reject { |pair| pair == [0,0] }
    pairs.each do |pair|  
      result << [pair[0] + x, pair[1] + y]
    end
    result.select { |pos| pos[0] >= 0 && pos[0] < ROW && pos[1] >= 0 && pos[1] < ROW  }
  end
  
  def neighbors_bomb_count(x, y)
    adj = neighbors(x, y)
    result = 0
    adj.each do |pos|
      tile = @rows[pos[0]][pos[1]]
      result += 1 if tile.mine
    end
    result
  end
end

class Game
  
  def initialize(num_bombs  = (ROW / 3) ** 2 )
    @board = Board.new(num_bombs)
    @time = 0
    @x = 0
    @y = 0
  end
  
  def display
    puts "\e[H\e[2J"
    @board.rows.each_with_index do |row, y1|
      row.each_with_index do |tile, x1|
        if x1 == @x && y1 == @y 
          tile.cursor = true
        else
          tile.cursor = false
        end
      end
      puts row.join(" ")
    end
  end
  
  def lost? 
    @board.rows.each do |row| 
      row.each do |tile| 
        return true if tile.revealed && tile.mine
      end
    end
    false
  end
  
  def won? 
    @board.rows.each do |row|
      row.each do |tile|
        return false if !tile.mine && !tile.revealed
      end
    end
    true
  end
  
  def get_tile(x, y)
    @board.rows[x][y]
  end
  
  def reveal(x, y)
    tile = get_tile(x, y)
    tile.revealed = true
    if tile.adj_bombs == 0
      @board.neighbors(x, y).each do |pos|
        reveal(pos[0], pos[1]) unless get_tile(pos[0], pos[1]).revealed
      end
    end
  end
  
  def reveal_all
    @board.rows.each do |row| 
      row.each do |tile|
        tile.flag = false 
        tile.revealed = true
      end
    end
  end
  
  def cursor 
    display
    begin
      system("stty raw -echo")
      char = STDIN.getc
    ensure
      system("stty -raw echo")
    end
    case char
    when "a"
      @x -= 1 unless @x == 0
    when "s"
      @y += 1 unless @y == ROW - 1
    when "d"
      @x += 1 unless @x == ROW - 1
    when "w"
      @y -= 1 unless @y == 0
    when "f"
      return "F"
    when "r"
      return "R"
    when "c"
      return "c"
    end
    cursor
  end
  
  
  def play(file = nil)
    start_time = Time.now
    if file 
      File.open(file) do |f|
        @board = YAML.load(f.read())
      end
    end
    until won? || lost?
      action = cursor
      
      tile = get_tile(@y, @x)
      case action
      when "F"
        tile.flag = !tile.flag
      when "R" 
        if tile.flag
          puts "That tile is flagged"
        else
          reveal(@y, @x)
        end
      when "c"
        File.open("save.ms", "w") do |f|
          f.puts @board.to_yaml
        end
        return
      end
    end
    finish = won? ? "Congrats you won" : "You Lost"
    total_time = Time.now - start_time
    reveal_all
    display
    puts "#{finish} in #{total_time} seconds"
  end
end

# Make this runnable as  script. Use the special: "#!/..." at the start.
if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end