

def rps(input)
  rps_array = ['rock', 'paper', 'scissors']
  
  computer_choice = rps_array.sample
    # 
  # if input == computer_choice
  #   outcome = "Tie!"
  # end
  case [computer_choice, input]
  when computer_choice == input
    outcome = 'Tie!'
  when ['rock', 'paper'], ["paper", "scissors"], ["scissors", "rock"]
    outcome = "User wins!"
  else 
    outcome = "Computer wins!"
  end
  
  [computer_choice, outcome]
    
end