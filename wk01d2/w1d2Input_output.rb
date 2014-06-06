
def guessing
  answer = (1..100).to_a.sample
  guesses = 0
  puts "Please guess a number between 1 and 100"
  guess = gets.chomp.to_i
  while guess != answer
    relative = (answer > guess) ? "low" : "high"
    puts "Sorry, please try again. Your guess was too #{relative}."
    guesses +=1
    guess = gets.chomp.to_i
  end
  puts "Congratulations! "
  puts "You guessed #{answer} correctly in #{guesses} guesses!"
end

def shuffle_file
  puts "Please enter the file to be shuffled."
  file = gets.chomp
  lines = File.readlines(file)
  lines.shuffle!
  filename = File.basename(file, ".*")
  File.open("#{filename}_shuffled.txt", "w") do |f|
    lines.each do |l|
      f.print l
    end
  end
end
      
  