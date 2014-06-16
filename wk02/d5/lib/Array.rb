class Array
  def my_uniq
    uniq_array = []
    self.each do |el|
      uniq_array << el unless uniq_array.include?(el)
    end
    uniq_array
  end
  
  def two_sum
    result = []
    self.each_with_index do |el1, i1|
      self.each_with_index do |el2, i2|
        next if i2 <= i1
        if el1 + el2 == 0
          result << [i1, i2]
        end
      end
    end
    result
  end
end

def my_transpose(matrix)
  result_matrix = Array.new(matrix.length) {[]}
  matrix.each do |row|
    row.each_with_index do |val, y|
      result_matrix[y] << val
    end
  end
  result_matrix
end

def stock_picker(arr)
  result = nil
  profit = 0
  (0...arr.length).each do |buy|
    (buy + 1...arr.length).each do |sell|
      if arr[sell] - arr[buy] > profit
        result = [buy, sell]
        profit = arr[sell] - arr[buy]
      end
    end
  end
  
  return result
end