
class Board
  
  def initialize
    @board = [[0,0,0], [0,0,0], [0,0,0]]
    @winner = nil
  end
  
  def won?
    vertical_win? || horizontal_win? || diagonal_win?
  end
  
  def vertical_win?
    @board.each do |row| 
      if row[0] == row[1] &&
         row[1 ]== row[2] && 
         row[0] != 0
        @winner = row[0]
        return true
      end
    end
    false
  end
  
  def horizontal_win?
    row1 = @board[0]
    row2 = @board[1]
    row3 = @board[2]
    (0..2).each do |index|
      if row1[index] == row2[index] && 
         row1[index] == row3[index] && 
         row1[index] != 0
        @winner = row1[index]
        return true
      end
    end
    false
  end
  
  def diagonal_win?
    if @board[0][0] == @board[1][1] &&
       @board[0][0]== @board[2][2] && 
       @board[1][1] != 0
      @winner = @board[1][1]
      true
    elsif @board[2][0] == @board[1][1] &&
          @board[2][0 ]== @board[0][2] && 
          @board[1][1] != 0
        @winner = @board[1][1]
      true
    else
      false
    end
  end
  
  def winner
    @winner
  end
  
  def empty?(pos)
    row = pos[0].to_i
    col = pos[1].to_i
    @board[row][col] == 0
  end
  
  def place_mark(pos, mark)
    row = pos[0].to_i
    col = pos[1].to_i
    @board[row][col] = mark
  end
  
  def display
    final_array = 
    @board.map do |row|
      "   #{row[0]}   |   #{row[1]}   |   #{row[2]}  "
    end
    puts final_array.join("\n-------|-------|-------\n")
  end
  
end

class Game
  
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end
  
  def play
    plays = 0
    while !@board.won? 
      @board.display
      mark = (plays % 2) + 1
      puts "Player #{mark}'s turn:"
      if mark == 1
        selected_move = @player1.move(@board)
      else
        selected_move = @player2.move(@board)
      end
      if @board.empty?(selected_move)
        plays +=1
        @board.place_mark(selected_move, mark)
      else
        puts "That space is already taken."
      end
    end
    puts "Player #{mark} won!"
    @board.display
  end
end

class Player
  
end

class HumanPlayer < Player
  
  def move(board)
    puts "Please enter the row number:"
    row = gets.chomp
   # if row > 2 || row < 0
    #  puts "sorry wrong number"
    puts "Please enter the column:"
    col = gets.chomp
    [row, col]
  end
  
end

class ComputerPlayer < Player
  
  def move(board)
    empty_spots = []
    (0..2).each do |row|
      (0..2).each do |idx|
        if board.empty?([row,idx])
          empty_spots << [row, idx]
        end
      end
    end
    empty_spots.sample
  end
  
end
