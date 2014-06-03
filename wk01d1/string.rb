

def num_to_s(num, base)
  num_map = {
    10 => 'A',
    11 => 'B',
    12 => 'C',
    13 => 'D',
    14 => 'E',
    15 => 'F',
    1 => '1',
    2 => '2',
    3 => '3',
    4 => '4',
    5 => '5',
    6 => '6',
    7 => '7',
    8 => '8',
    9 => '9',
    0 => '0'
  }

  result = ""
  power = 0
  while base ** power <= num do
    #puts "power = #{power}"
    number_for_hash = (num / (base ** power)) % (base ** (power + 1))
    number_for_hash %= base #addressing bug where number does not wrap around
    #puts "number for hash = #{number_for_hash}"
    result = num_map[number_for_hash] + result
    power += 1
  end
  result
end

def num_to_s_test
  inputs = {
    [5, 10] => "5",
    [5, 2]  => "101",
    [5, 16] => "5",
    [234, 10] => "234",
    [234, 2]  => "11101010",
    [234, 16] => "EA" ,

  }
  inputs.each do |test, result|
    if num_to_s(test[0], test[1]) != result
      puts "Failed for #{test[0]}, #{test[1]}. \n Expected #{result}, got #{num_to_s(test[0], test[1])}."
    else
      puts "PASS"
    end
  end
end


def caesar(str, offset)
  letters = ("a".."z").to_a
  result = ""
  str.each_char do |char|
    ord = letters.index(char)
    result << letters[(ord + offset) % 26]
  end
  result
end
