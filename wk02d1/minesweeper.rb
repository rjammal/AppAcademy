require 'debugger'
require 'time'
require 'yaml'

class Tile
  
  attr_accessor :flag, :revealed, :mine, :value, :cursor
  
  def initialize
    @flag = false
    @revealed = false
    @mine = false
    @value = 0
    @cursor = false
  end

  def to_s
    return "# " if @cursor
    return "F " if @flag 
    if @revealed
      return "* " if @mine
      return "  " if @value == 0
      return @value.to_s + " "
    end
    return "[]"
  end
end

class Board
  attr_accessor :rows
  def initialize(bombs = 10)
    @rows = Array.new(9) {Array.new(9) {Tile.new} }
    until bombs == 0
      tile = @rows[rand(9)][rand(9)]
      next if tile.mine
      tile.mine = true
      bombs -= 1
    end
    @rows.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        tile.value = neighbors_bomb_count(x, y)
      end
    end
  end
  
  def neighbors(x, y)
    result = []
    result_check = ["+", "-"]
    num = [1,0]
    
    result_check.each do |x_op|
      result_check.each do |y_op|
        num.each do |x_dif|
          num.each do |y_dif|
            next if y_dif == 0 && x_dif == 0
            result << [eval("#{x} #{x_op} #{x_dif}"), eval("#{y} #{y_op} #{y_dif}")]
          end
        end
      end
    end
    result.uniq.select { |pos| pos[0] >= 0 && pos[0] < 9 && pos[1] >= 0 && pos[1] < 9  }
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
  
  def initialize(num_bombs = 10)
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
    if tile.value == 0
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
      @y += 1 unless @y == 8
    when "d"
      @x += 1 unless @x == 8
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
