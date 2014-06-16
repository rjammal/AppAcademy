
class PolyTreeNode
  
  attr_reader :parent, :value, :children
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent=(node)
    return unless valid?(node)
    unless @parent.nil?
      @parent.children.delete(self)
    end
    unless node.nil?
      node.children << self
    end  
    @parent = node
  end
  
  def trace_path_back
    result = []
    node = self
    while node != nil
      result << node.value
      node = node.parent
    end
    result.reverse     
  end
  
  def valid?(node)
    if node.nil?
      true
    elsif node.children.include?(self)
      false
    else
      true
    end
  end
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_to_remove)
    child_to_remove.parent = nil
  end
  
  def dfs(value)
    if self.value == value
      self
    else
      node_found = nil
      self.children.each do |child|
        node_found = child.dfs(value)
        break if node_found
      end
      node_found
    end
  end
  
  def bfs(value)
    queue = [self]
    until queue.empty?
      current = queue.shift
      if current.value == value
        return current
      else
        current.children.each { |child| queue.push(child) }
      end
    end
    nil
  end
end