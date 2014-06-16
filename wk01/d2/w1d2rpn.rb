class RPN
  def initialize
    @numbers = []
  end
  
  def prompt
    if validate?
      puts "Please enter a number, or an operator (+, -, *, /, %), or type 'break' to end the program."
    else
      puts "Please enter a number, or type 'break' to close the program"
    end
    input = gets.chomp
    do_logic(input)
    prompt
  end
  
  def do_logic(input)
    if input == 'break'
      return
    elsif input =~ /^\d+$/
      @numbers << input.to_i
    elsif ['+', '-', '*', '/', '%'].include?(input)
      if validate?
        calculate(input) 
      else
        puts "There are not enough digits for that operation." 
      end
    else
      puts "Invalid input."
    end
  end
  
  def validate?
    @numbers.length >= 2
  end
  
  def calculate(input)
    temp = @numbers.pop
    @numbers[-1] = @numbers[-1].send(input, temp)
    puts @numbers[-1] 
  end    
end


if __FILE__ == $PROGRAM_NAME
  r = RPN.new
  if ARGV.empty?
    r.prompt
  else 
    lines = File.readlines(ARGV[0])
    lines.map!(&:chomp)
    lines.each {|line| r.do_logic(line)}
  end
end
