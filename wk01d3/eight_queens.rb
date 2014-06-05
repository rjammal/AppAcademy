
def eight_queens
  eight_rooks.select { |soln| !diagonal(soln) }
end

def diagonal(soln)
  soln.each_with_index do |coords, i1| 
    (1...soln.length).times do |i2|
      if i2 <= i1
        next
      end
      if positive_1_slope?(coords, soln[i2])
        return true
      end
    end
  end
  false
end

def positive_1_slope?(coord1, coord2)
  difference_in_y = coord2[1] - coord1[1]
  difference_in_x = coord2[0] - coord1[0]
  Math::abs(difference_in_y / difference_in_x.to_f) == 1.0
end

def eight_rooks
  solutions = []
  # add first position
  (1..8).each do |x_coord|
    solution = []
    (1..8).each do |y_coord|
      
    end
  end
  
end

def eight_rook_solution(seed)
  