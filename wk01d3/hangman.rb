class Game
  
  def initialize(guessing_player,checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
    @output = @checking_player.initialize_output
    @past_guesses = []
    @guessing_player.load_words_of_length(@output.length)
  end
  
  def play
    while @output.include?('_')
      puts print_output
      guess = @guessing_player.guess(@past_guesses)
      puts "#{@guessing_player} guessed #{guess}. "
      positions = @checking_player.answer_to_guess(guess)
      @guessing_player.handle_positions(guess,positions)
      modify_output(positions, guess)
      @past_guesses << guess
      puts "#{@guessing_player} has guessed #{@past_guesses.join(", ")}" 
    end
    puts print_output
    puts "Nice game!"
  end
  
  def modify_output(position_array, char)
    position_array.each do |index|
      @output[index] = char
    end
  end
  
  def print_output
    @output.split("").join(" ")
  end
  
end

class Player
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    @name
  end
  
  
  def generate_underscores(num)
    result = ""
    num.times {result << "_"}
    result
  end
end

class HumanPlayer < Player
  
  #Methods for human checker
   
  def initialize_output
    begin
      puts "Please enter the length of your word."
      input_length = Integer(gets.chomp)
    rescue => error
      puts error
      retry
    end
    
    generate_underscores(input_length)
  end
  
  def answer_to_guess(guess_input)
    result = []
    puts "One by one, enter the positions where the letter appears from left to right. 
    The first position is labelled 0, the second is 1, etc. If the letter does not appear,
    type 'n'. After entering all positions, type 'n'"
    position = gets.chomp
    while position != "n"
      result << position.to_i
      puts "Are there any more positions?"
      position = gets.chomp
    end
    result
  end
  
  #Methods for human guesser
  def guess(previous_guesses)
    puts "Enter a guess."
    g = gets.chomp.downcase
    if previous_guesses.include?(g)
      puts "You've already guessed #{g}. Please guess again."
      guess(previous_guesses)
    else
      g
    end   
  end
  
  def handle_positions(guess,positions)
  end
  
  def load_words_of_length(length)
  end
  
end



class ComputerPlayer < Player
  
  # methods for checking
  def initialize_output
    @secret_word = get_dictionary.sample    
    generate_underscores(@secret_word.length)
  end
    
  
  
  # methods for computer guesser
  
  def load_words_of_length(length)
    @dictionary = get_dictionary.select {|word| word.length == length}
  end
  
  def handle_positions(guess, positions)
    if positions.empty?
      @dictionary.select! {|word| !word.include?(guess)}
    else
      @dictionary.select! do |word|
        letter_array = []
        word.split("").each_with_index do |char, index|
          letter_array << index if char == guess 
        end
        letter_array == positions
      end
    end
  end
  
  def guess(previous_guesses)
    counts = Hash.new(0)
    @dictionary.each do |word| 
      word.each_char {|char| counts[char] += 1}
    end
    max = 0
    result = nil
    counts.each do |key, value|
      if value > max && !previous_guesses.include?(key)
        max = value
        result = key
      end
    end
    result
  end
  
  def answer_to_guess(guess_input)
    result = []
    @secret_word.split("").each_with_index do |char, i|
      if guess_input == char
        result << i
      end
    end
    result
  end
  
  private
  
    def get_dictionary
      File.readlines("dictionary.txt").map(&:chomp)
    end
  
  
    def test_handle_positions
      load_words_of_length(6)
      handle_positions("a", [1,3])
      p @dictionary
      handle_positions("n", [])
      p @dictionary
    end  
end

