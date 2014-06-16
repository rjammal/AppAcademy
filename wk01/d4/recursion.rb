require 'debugger'

def range(start_num, end_num)
  if start_num == end_num
    [start_num]
  else
    range(start_num, end_num - 1) << end_num
  end
end

def sum_recursive(numbers)
  if numbers.length == 1
    return numbers[0]
  else
    sum_recursive(numbers[1..-1]) + numbers[0]
  end
end

def sum_iterative(numbers)
  sum = 0
  i = 0
  while i < numbers.length
    sum += numbers[i]
    i += 1
  end
  sum
end

def exponentiation_1(base, exp)
  if exp == 0
    1
  else
    exponentiation_1(base, exp - 1) * base
  end
end

def exponentiation_2(base, exp)
  if exp == 0
    1
  elsif exp == 1
    base
  elsif exp.even?
    value = exponentiation_2(base, exp / 2) 
    value * value
  else
    base * exponentiation_2(base, (exp - 1))
  end
end

class Array
  def deep_dup
    duplicate = []
    self.each do |elem|
      if elem.is_a?(Array)
        duplicate << elem.deep_dup
      else
        duplicate << elem.class.new(elem)
      end
    end
    duplicate
  end
end

def fibonacci_recursive(n)
  result = []
  if n == 1
    result << 1
  elsif n == 2
    result = [1, 1]
  else
    one_less = fibonacci_recursive(n - 1)
    one_less << one_less[-1] + one_less[-2]
    result = one_less
  end
  result
end

def fibonacci_iterative(n)
  result = []
  while result.length < n
    if result.length < 2
      result << 1
    else
      result << result[-1] + result[-2]
    end
  end
  result
end

def binary_search(array, target)
  raise "Error: must input a sorted array." unless array == array.sort
  return nil if array.length == 0
  middle_index = array.length / 2
  middle_elem = array[middle_index]
  if array.length == 1 && target != array[0]
    nil
  elsif middle_elem == target
    middle_index
  elsif middle_elem < target
    result = binary_search(array[middle_index..-1], target) 
    result + middle_index unless result.nil?
  else
    binary_search(array[0...middle_index], target)
  end
end

def make_change1(total, coins)
  change = []
  if total == 0
    []
  else
    max_coin = coins.select {|coin| total > coin}[0]
    num_coins = total / max_coin
    num_coins.times { change << max_coin }
    change += make_change1(total - (max_coin * num_coins), coins) 
  end
  change
end

def make_change2(total, coins)
  change = []
  if total == 0
    []
  else
    max_coin = coins.select {|coin| total > coin}[0]
    change << max_coin 
    change += make_change2(total - max_coin, coins) 
  end
  change
end

def make_change3(total, coins)
  if total == 0
    []
  else
    smaller_coins = coins.select {|coin| total >= coin}
    best_result = nil
    smaller_coins.each do |coin| 
      temp_result = []
      temp_result << coin
      valid_coins = coins.select { |each_coin| each_coin <= coin }
      temp_result += make_change3(total - coin, valid_coins)
      if best_result.nil? || temp_result.length < best_result.length
        best_result = temp_result
      end
    end
    best_result
  end
end

class Array
  def merge_sort
    if self.length <= 1
      return self
    end
    first_half = self[0...self.length/2]
    second_half = self[self.length/2..-1]
    merge(first_half.merge_sort, second_half.merge_sort)
  end

  def merge(arr1, arr2)
    arr1_index = 0
    arr2_index = 0
    result = []
    while arr1_index < arr1.length && arr2_index < arr2.length
      if arr1[arr1_index] < arr2[arr2_index]
        result << arr1[arr1_index]
        arr1_index += 1
      else
        result << arr2[arr2_index]
        arr2_index += 1
      end
    end
    result + arr1[arr1_index..-1] + arr2[arr2_index..-1]
  end
  
  def subsets
    result = []
    result << self
    if self.length > 0
      self.each do |num|
        result += self.select { |item| item != num }.subsets
      end
    end
    result.uniq
  end
  
  def recursive_includes?(num)
    return false if self.empty?
    self[0] == num || self[1..-1].recursive_includes?(num)
  end
end

def num_occur(numbers, value)
  return 0 if numbers.empty?
  occurences = 0
  if numbers[0] == value
    occurences = 1
  end
  occurences + num_occur(numbers[1..-1], value) 
end

def add_to_twelve?(numbers)
  return false if numbers.length <= 1
  numbers[0] + numbers[1] == 12 || add_to_twelve?(numbers[1..-1])
end

def sorted?(arr)
  if arr.length <= 1
    true
  elsif arr[0] <= arr[1] 
    sorted?(arr[1..-1])
  else
    false
  end
end

def reverse(num)
  return num if num.to_s.length == 1
  result = ''
  ones = num % 10
  rest_of_num = reverse(num / 10)
  result += ones.to_s + rest_of_num.to_s
  result.to_i
end
