require_relative 'TTT'
require "debugger"


class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board = Board.new, prev_move_pos = nil)
    @board = board
    @next_mover_mark = :x
    @prev_move_pos = prev_move_pos
  end
  
  def children
    result = []
    empty_positions = []
    (0..2).each do |x|
      (0..2).each do |y|
        empty_positions << [x,y] if @board.empty?([x,y])
      end
    end
    empty_positions.each do |empty_spot|  
      new_game_state = TicTacToeNode.new(@board, empty_spot)
      new_game_state.board = @board.dup
      new_game_state.board[empty_spot] = @next_mover_mark
      if @next_mover_mark == :o 
        new_game_state.next_mover_mark = :x
      else 
        new_game_state.next_mover_mark = :o
      end
      result << new_game_state
    end
    result
  end
  
  def losing_node?(player)
    
    if @board.over?
      return @board.winner != player
    end
    loser_children = children.all? { |child| child.losing_node?(player) }
    return true if @next_mover_mark == player && loser_children
    any_child_loses = children.any? { |child| 
      puts "child is #{child} and child losing is #{child.losing_node?(player)}"
      child.losing_node?(player) }
    @next_mover_mark != player && any_child_loses
    
  end
  
  def winning_node?(player)
    if @board.over?
      return @board.winner == player
    end
    winner_children = children.any? { |child| child.winning_node?(player) }
    if @next_mover_mark == player && winner_children
      return true 
    end
    all_children_win = children.all? { |child| child.winning_node?(player) }
    @next_mover_mark != player && all_children_win
  end
      
  def new_one(ka)
    puts ka "YES! we win"
  end
end

class SuperComputerPlayer < ComputerPlayer
  
  def move(game, mark)
    board = game.board
    ticky_tack_node = TicTacToeNode.new(board)
    ticky_tack_node.children.each do |game_state|
      if game_state.winning_node?(mark)
        return game_state.prev_move_pos
      end
    end
    ticky_tack_node.children.each do |game_state|
      if !game_state.losing_node?(mark)
        return game_state.prev_move_pos
      end
    end
    raise "there are no non losing nodes!!!!!!!!!!"
  end
end