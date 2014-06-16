require "debugger"

class Fixnum

  def in_words(level = 0)
    oddballs = {
      "0" => "zero",
      "1" => "one",
      "2" => "two",
      "3" => "three",
      "4" => "four",
      "5" => "five",
      "6" => "six",
      "7" => "seven",
      "8" => "eight",
      "9" => "nine",
      "10" => "ten",
      "11" => "eleven",
      "12" => "twelve",
      "13" => "thirteen",
      "14" => "fourteen",
      "15" => "fifteen",
      "16" => "sixteen",
      "17" => "seventeen",
      "18" => "eighteen",
      "19" => "nineteen",
      "20" => "twenty",
      "30" => "thirty",
      "40" => "forty",
      "50" => "fifty",
      "60" => "sixty",
      "70" => "seventy",
      "80" => "eighty",
      "90" => "ninety"
    }

    big_modifiers = [
      "",
      "thousand",
      "million",
      "billion",
      "trillion"
    ]

    return 'zero' if self == 0

    num_str = self.to_s
    #debugger
    if num_str.length == 1
      if level == 0
        num_str == '0' ? "" : oddballs[num_str]
      elsif oddballs[num_str] == "zero"
        ""
      else
        "#{oddballs[num_str]} #{big_modifiers[level]}"
      end
    elsif num_str.length == 2
      if oddballs[num_str]
        tens_result = oddballs[num_str]
      else
        tens = oddballs[num_str[0] + "0"]
        ones = oddballs[num_str[1]]
        tens_result = "#{tens} #{ones}"
      end
      if level > 0
        tens_result += " " + big_modifiers[level]
      end
      tens_result
    elsif num_str.length == 3
      hundred = oddballs[num_str[0]]
      if hundred == "zero"
        hundred = ""
      end
      tens_and_ones = num_str[-2..-1].to_i.in_words
      if tens_and_ones == "zero"
        tens_and_ones = ""
      end
      show_hundred = hundred.empty? ? "" : " hundred"
      "#{hundred}#{" hundred" unless hundred.empty?}#{" " unless tens_and_ones.empty?}#{tens_and_ones}#{" " + big_modifiers[level] if level > 0}"
    else
      thousands_and_up = num_str[0...-3].to_i
      hundreds = num_str[-3..-1].to_i
      "#{thousands_and_up.in_words(level + 1)}#{" " + hundreds.in_words(level) if hundreds.in_words(level) != "zero"}"
    end
  end

end
