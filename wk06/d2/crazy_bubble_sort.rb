def crazyBubbleSort(arr)
  ####### looping construct, aka the sortPassCallback
  swapsMade = true
  while swapsMade do
    # ******** actual swapping, the performSortPass method
    swapsMade = false
    arr.each_with_index do |el, i| 
      # $$$$$$$ ask user to compare
      lessThan = gets.chomp
      # $$$$$$$ ask user to compare
      if lessThan # this has to be a callback to the user input function
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        swapsMade = true
      end
    end
    # ******** actual swapping, the performSortPass method
  end
  ####### looping construct, aka the sortPassCallback
  
  # this is where the sortCompletionCallback goes
  puts arr
end