
def times_2(int_array)
  int_array.map { |x| x * 2 }
end

class Array

  def my_each
    index = 0
    while index < self.length
      yield self[index]
      index += 1
    end
    self
  end
end


def median(int_array)
  if int_array.length.odd?
    int_array.sort[int_array.length / 2]
  else
    sorted = int_array.sort
    first_num = sorted[int_array.length / 2]
    second_num = sorted[(int_array.length / 2) - 1]
    (first_num + second_num) / 2.0
  end
end

def concatenate(str_array)
  str_array.inject("") do |accum, elem|
    accum + elem
  end
end
