
require './checkers_board.rb'

class NoPieceException < Exception
end

class NotYourColorException < Exception
end

class CheckersGame

  attr_accessor :turn
  attr_reader :red, :black, :board, :force_jumps

  def initialize(force_jumps = true, player1 = Player.new, player2 = Player.new)
    @red = player1
    @black = player2
    @turn = :red
    @board = CheckersBoard.new
    @force_jumps = force_jumps
  end

  def play
    puts "Let's play checkers!"
    until won?
      puts board
      puts "It's #{turn}'s turn."
      begin
        puts "Please enter the coordinates of the piece you want to move. "
        puts "Example: 3, 4"
        start_pos = validate_start
        puts "Please enter the coordinates you want to move to. "
        move_seq = []
        move_seq << validate_input
        puts "If there are more moves (chain jumps), please enter them now. Otherwise, type 'n'."
        chain_moves = gets.chomp.downcase
        while chain_moves != 'n'
          move_seq << validate_input(chain_moves)
          puts "Any more?"
          chain_moves = gets.chomp.downcase
        end
        piece = board[*start_pos]
        piece.perform_moves(move_seq, force_jumps)
      rescue InvalidMoveError => e
        puts e.message
        puts "Please try another move."
        retry
      rescue NotAJumpException => e
        puts "Force jumps are enabled."
        puts e.message
        puts "Please select a move that jumps another piece."
        retry
      end
      if turn == :red 
        @turn = :black
      else
        @turn = :red
      end
    end
    puts board
    puts "Congratulations, #{winner} player! You win!"
  end

  def validate_start
    begin
      start_pos = validate_input
      if board.empty?(*start_pos)
        raise NoPieceException.new "There's no piece there."
      elsif board[*start_pos].color != turn
        raise NotYourColorException.new "It's #{turn}'s turn. That piece is #{board[*start_pos].color}. "
      end
      start_pos
    rescue NoPieceException, NotYourColorException => e
      puts e.message
      puts "Please try again."
      retry
    end
  end

  def validate_input(raw = nil)
    begin
      raw ||= gets.chomp.gsub(" ","")
      raw_arr = raw.split(",")
      if raw_arr.length != 2 || !raw_arr.all? { |coord| coord =~ /^\d+$/ }
        raise ArgumentError.new "That is not a valid coordinate." 
      end
      num_arr = raw_arr.map { |coord| coord.to_i - 1}
      if num_arr.any? { |num| !(0..7).include?(num) }
        raise OffBoardException.new "That is not on the board."
      end
      num_arr
    rescue ArgumentError, OffBoardException => e
      puts e.message
      puts "Please enter another coordinate."
      retry
    end
  end


  def won?
    board.get_pieces(:red).length == 0 || board.get_pieces(:black).length == 0
  end

  def winner
    if won?
      if board.get_pieces(:red) == 0
        :black
      else
        :red
      end
    end
  end
end

class Player
end