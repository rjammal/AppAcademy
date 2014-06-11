require './board.rb'

class Game
  def initialize(white_player, black_player)
    @white_player = white_player
    @black_player = black_player
    @whites_turn = true
    @board = Board.new
  end
  
  def won?
    if @whites_turn
      @board.checkmate?(:white)
    else
      @board.checkmate?(:black)
    end
    
  end
  
  def winner
    if won?
      if @whites_turn
        :black
      else
        :white
      end
    else
      nil
    end
  end
  
  def play
    while !won?
      puts @board.to_s
      if @whites_turn
        turn = "white"
      else
        turn = "black"
      end
      puts "It's #{turn}'s turn."
      
      if @whites_turn
        @white_player.move(@board, :white) #create move method in player class
      else
        @black_player.move(@board, :black)
      end
      @whites_turn = !@whites_turn
    end
    puts @board.to_s
    puts "That's checkmate. #{winner.to_s.capitalize} is the winner! "
  end
end


class Player
  
  def move(board, color)
    
    begin
      puts "You are in check!" if board.in_check?(color)
      puts "Enter a piece to move. "
      puts "Example: a5"
      start = parse_input
      
      puts "Where should it move? "
      end_pos = parse_input
      board.move(start, end_pos, color)
    rescue ArgumentError, InCheckException => e
      puts e.message
      retry
    end
  end
  
  def parse_input
    x_hash = {
      "a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5, "g" => 6, "h" => 7
    }
    begin 
      raw = gets.chomp.split("")
      if raw.length != 2
        raise ArgumentError.new "Please enter two characters, a letter followed by a number."
      elsif !x_hash.keys.include?(raw[0].downcase)
        raise ArgumentError.new "The first character should be a letter from a to h. "
      elsif !("1".."8").include?(raw[1])
        raise ArgumentError.new "The second character should be a number from 1 to 8"
      end
      raw[0] = x_hash[raw[0]]
      raw[1] = raw[1].to_i - 1
      raw
    rescue ArgumentError => e
      puts e.message
      puts "Please try again"
      retry
    end
  end

end

#TODO extras include tie, stalemate

