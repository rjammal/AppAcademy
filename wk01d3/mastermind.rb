class Game
  COLORS = ['R', 'G', 'B', 'Y', 'O', 'P']
  
  def play
    set_random_code
    num_guesses = 0
    guess = ""
    puts "Please guess a sequence of four colors. Your choices are 'R' for Red, 'G' for Green, 'B' for Blue, 'Y' for Yellow, 'O' for Orange, and 'P' for Purple."
    puts "Example: RGBY"
    
    while guess != @answer && num_guesses < 10
      begin
        guess = gets.chomp
        valid(guess)
      rescue ArgumentError => e
        puts "#{guess} is not a valid input"
        puts "Error was: #{e.message}"
        retry
      end
      num_guesses += 1
      puts exact_matches(guess)
      puts near_matches(guess)
      puts "Please guess again. "
      puts "#{10 - num_guesses} guesses left!"
    end
    if num_guesses < 10
      puts "#{@answer} is correct! Congratulations! You win!"
    else
      puts "You lose. The correct answer was #{@answer}"
    end
  end
  
  private 
  
  def set_random_code
    result = ""
    4.times { result << COLORS.sample}
    @answer = result
  end
  
  def exact_matches(guess)
    num_exact = 0
    4.times {|index| num_exact += 1 if guess[index] == @answer[index]  }
    "You have #{num_exact} exact matches."
  end
  
  def near_matches(guess)
    num_near = 0
    array_guess = guess.split("")
    4.times do |index| 
      included = array_guess.include?(@answer[index])
      exact_match = @answer[index] == guess[index] 
      if included and !exact_match
        num_near += 1 
      end
    end
    "You have #{num_near} near matches."
  end
  
  def valid(guess)
    if guess.length != 4
      raise ArgumentError.new "Length needs to be 4"
    end
    guess.each_char { |char| raise ArgumentError.new "not valid color" if !COLORS.include?(char) }
    true
  end
end

