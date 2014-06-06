class Array
  def my_each(&prc)
    for i in 0...self.length
      prc.call(self[i])
    end
    self
  end
  
  def my_map(&prc)
    result = []
    self.my_each |item| do
      result << prc.call(item)
    end
    result
  end
  
  def my_select(&prc)
    result = []
    self.my_each do |item|
      result << item if prc.call(item)
    end
    result
  end
  
  def my_inject(&prc)
    acc = self.first 
    first = true
    
    self.my_each do |current|
      if first
        first = false
        next
      end
  
      acc = prc.call(acc, current)
    end
    acc
  end
  
  def my_sort!(&prc)
    sorted = false
    until sorted
      sorted = true
      (0...self.length - 1).each do |i|
        if prc.call(self[i], self[i + 1]) > 0
          sorted = false
          self[i], self[i + 1] = self[i + 1], self [i]
        end
      end
    end
    self
  end
end