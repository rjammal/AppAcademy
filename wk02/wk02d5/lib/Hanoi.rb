class IllegalMove < Exception
end

class Hanoi
  
  def initialize
    @towers = [[1,2,3], [], []]
  end
  
  def move(start_tower, end_tower)
    stack1 = @towers[start_tower - 1]
    stack2 = @towers[end_tower - 1]
    
    if stack1.empty?
      raise IllegalMove.new "The start stack is empty"
    elsif stack2.length > 0 && stack1[0] > stack2[0]
      raise IllegalMove.new "You cannot move a larger disc onto a smaller one."
    else
      disc = @towers[start_tower - 1].shift
      @towers[end_tower - 1].unshift(disc)
    end
  end
  
  def render
    result = ""
    @towers.each do |tower|
      result << tower.join(" ")
      result << "\n"
    end
    result
  end
  
  def won? 
    @towers[2] == [1, 2, 3]
  end
end