
class MyHashSet

  def initialize
    @store = Hash.new(false)
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store[el]
  end

  def delete(el)
    present = @store[el]
    @store[el] = false
    present
  end

  def to_a
    @store.keys.select {|x| @store[x]}
  end

  def union(set2)
    result = MyHashSet.new
    self.to_a.each {|value| result.insert(value)}
    set2.to_a.each {|value| result.insert(value)}
    result
  end

  def intersect(set2)
    result = MyHashSet.new
    self.to_a.each do |value|
      if set2.include?(value)
        result.insert(value)
      end
    end
    result
  end

  def minus(set2)
    result = MyHashSet.new
    self.to_a.each {|value| result.insert(value) unless set2.include?(value)}
    result
  end
end



def correct_hash hsh
  result = {}
  hsh.each do |key, value|
    result[value[0].to_sym] = value
  end
  result
end

