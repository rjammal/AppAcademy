#Implement a Rock, Paper, Scissors game. The method rps should take a string (either "Rock", "Paper" or "Scissors") as a parameter and return the computer's choice, and the outcome of the match. Example:

def rps(input)
  rps_array = ['rock', 'paper', 'scissors']
  computer_choice = rps_array.sample
  if input == computer_choice
    return [computer_choice, "Tie!"]
  end
  
  case [computer_choice, input]
  when ['rock', 'paper'], ["paper", "scissors"], ["scissors", "rock"]
    outcome = "User wins!"
  else 
    outcome = "Computer wins!"
  end
  
  [computer_choice, outcome]
    
end


#Implement a Mixology game. The method remix should take an array of ingredient arrays (one alcohol, one mixer) and return the same type of data structure, with the ingredient pairs randomly mixed up. Assume that the first item in the pair array is alcohol, and the second is a mixer. Don't pair an alcohol with an alcohol with or a mixer with a mixer. make a version of the Mixology game that guarantees that all the alcohols end up with a different mixer!

def remix(ingredients)
  alcohol = ingredients.map {|el| el[0]}
  mixers = ingredients.map {|el| el[1] }
  alcohol.shuffle!
  mixers.shuffle!
  result = []
  alcohol.each_with_index do |al, i| 
    result << [al, mixers[i]]
  end
  result
end
