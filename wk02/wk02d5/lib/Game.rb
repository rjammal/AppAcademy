require_relative 'Hanoi.rb'

class Game
  
  def initialize
    @stacks = Hanoi.new
  end
    
  def play
    until @stacks.won?
      tower1 = gets.chomp.to_i
      tower2 = gets.chomp.to_i
      
      @stacks.move(tower1, tower2)
    end
  end
end