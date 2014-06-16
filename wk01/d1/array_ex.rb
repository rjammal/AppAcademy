
class Array
  def my_uniq
    result = Array.new
    self.each do |elem|
      if !result.include?(elem)
        result.push(elem)
      end
    end
    result
  end

  def two_sum
    result = []
    self.each_with_index do |first, i1|
      self.each_with_index do |second, i2|
        next unless i2 > i1
        if first + second == 0
          result.push([i1, i2])
        end
      end
    end
    result
  end
end

def tower
  peg2 = []
  peg3 = []

  peg1 = (1..7).to_a
  catch(:quit) do
    while peg3 != (1..7).to_a do
      mapping = { "1" => peg1, "2" => peg2, "3" => peg3 }

      begin
        puts "Where are you moving a disc from? (Enter 1, 2, or 3)"
        from = gets.chomp
        puts "Where are you moving the disc to? (Enter 1, 2, or 3)"
        to = gets.chomp
        keys = mapping.keys
        if from == "q" || to == "q"
          throw(:quit)
        end
        if !keys.include?(from) || !keys.include?(to)
          raise Exception.new('incorrect input!')
        end
      rescue Exception => e
        puts e
        retry
      ensure
        puts 'we will always get here!'
      end

      from_peg = mapping[from]
      to_peg = mapping[to]

      if from_peg.empty?
        puts "The from peg is empty!"
      elsif !to_peg.empty? && from_peg[0] > to_peg[0]
        puts "Not a valid move!"
      else
        disc = from_peg.shift
        to_peg.unshift(disc)
      end
      puts "Peg 1 = #{peg1}"
      puts "Peg 2 = #{peg2}"
      puts "Peg 3 = #{peg3}"
    end

  puts "You solved it!"
  end
end

def my_transpose matrix
  result = []
  order = matrix.length
  order.times {result << []}
  matrix.each_with_index do |row|
    row.each_with_index do |elem, i|
      result[i] << elem
    end
  end
  result
end

def stock_picker prices
  low = 0
  high = 0
  alt_low = 0
  prices.each_with_index do |price, i|
    if price > prices[high] #new high price
      high = i
      low = alt_low
    elsif price < prices[low] #new low, but might not be greatest difference
      alt_low = i
    else # not a new high but might be a new biggest diff
      old_diff = prices[high] - prices[low]
      new_diff = price - prices[alt_low]
      if new_diff > old_diff
        low = alt_low
        high = i
      end
    end
  end
  [low, high]
end





