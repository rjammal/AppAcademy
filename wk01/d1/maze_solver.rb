require 'debugger'

if ARGV.length == 0
  puts "Please supply a file."
  return
end

begin
  f = File.open(ARGV[0])
rescue FileNotFoundException
  puts "Could not find #{ARGV[0]}. Please soecify another file. "
  return
end

lines = f.readlines()
maze = lines.map { |row| row.chomp.split("") }

# find start and exit and initial position
start = nil
exit = nil
position = nil
maze.each_with_index do |row, row_i|
  row.each_with_index do |col, col_i|
    if col == "S"
      start = [row_i, col_i]
      position = [row_i, col_i]
    elsif col == "E"
      exit = [row_i, col_i]
    end
  end
end

def valid?(space, maze)
  value = maze[space[0]][space[1]]
  value != '*' && value != 'X' && value!= 'S'
end


while position != exit
  #debugger
  current_row = position[0]
  current_col = position[1]
  maze[current_row][current_col] = 'X' unless maze[current_row][current_col] == 'S'
  space_above = [current_row - 1, current_col]
  space_right = [current_row, current_col + 1]
  space_below = [current_row + 1, current_col]
  space_left  = [current_row, current_col - 1]
  if valid?(space_above, maze)
    position = space_above
  elsif valid?(space_right, maze)
    position = space_right
  elsif valid?(space_below, maze)
    position = space_below
  elsif valid?(space_left, maze)
    position = space_left
  else
    puts "Boxed in!"
    return
  end
end

puts "You made it out!"
maze.each do |row|
  puts row.join("")
end





