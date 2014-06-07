require "./PolyTreeNode"
require 'debugger'
class KnightPathFinder
  
  def initialize(start_pos)
    @position = start_pos
    @visited_positions = [start_pos]
    @move_paths = build_move_tree
  end
  
  def build_move_tree
    root = PolyTreeNode.new(@position)
    positions_to_process = [root]
    
    until positions_to_process.empty?
      current_node = positions_to_process.shift
      new_positions = new_move_pos(current_node.value)
      new_positions.each do |position| 
        new_node = PolyTreeNode.new(position)
        new_node.parent = current_node
        positions_to_process << new_node
      end
    end
    root
  end
  
  def self.valid_moves(pos)
    moves = []
    #[[0, 1], [2, 2]]
    distances1 = [1, -1]
    distances2 = [2, -2]
    
    moves += valid_move_helper(pos, distances1, distances2)
    moves += valid_move_helper(pos, distances2, distances1)
    moves
  end
  
  def new_move_pos(pos)
    new_moves = KnightPathFinder.valid_moves(pos).select do |coordinants|
      !@visited_positions.include?(coordinants)
    end
    @visited_positions += new_moves
    new_moves
  end
  
  def find_path(end_pos)
    end_node = @move_paths.bfs(end_pos)
    end_node.trace_path_back
  end
  
  private
  def self.valid_move_helper(pos, x_additions, y_additions)
    moves = []
    x_additions.each do |x|
      y_additions.each do |y|
        if pos[0] + x < 0 || pos[0] + x > 7
          next
        elsif pos[1] + y < 0 || pos[1] + y > 7
          next
        else
          moves << [pos[0] + x, pos[1] + y]
        end
      end
    end
    moves
  end
  
end