#Write a loop that finds the first number that is (a) >250 and (b) divisible by 7. Print this number!

def find_7over250
  n = 250
  while n%7 != 0
    n+=1
  end
  puts n
end

#Write a method factors that prints out all the factors of a given number.

def factors(num)
  (1..Math::sqrt(num)).each do |x|
    if num % x == 0
      puts x
      puts num/x
    end
  end
  nil
end

#Implement Bubble sort in a method #bubble_sort that takes an Array and modifies it so that it is in sorted order.

def bubble_sort arr
  result = arr.clone
  unsorted = true
  while unsorted
    unsorted = false
    (0...result.length - 1).each do |i| 
      if result[i] > result[i + 1]
        unsorted = true
        result[i] , result[i+1] = result[i+1], result[i]
      end
    end
  end
  result
end
      

def substrings(string)
  word_length = 1
  result = []
  while word_length <= string.length
    (0..string.length-word_length).each do |i|
      result << string[i,word_length]
    end
    word_length +=1
  end
  result
end


def subwords(string)
  lines = File.readlines("dictionary.txt")
  lines.map! {|line| line.chomp }
  substrings(string).select {|word| lines.include?(word)}
end
