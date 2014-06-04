def super_print(string, options = {})
  if !options[:times]
    options[:times] = 1
  end
  if options[:upcase]
    string.upcase!
  end
  if options[:reverse]
    string.reverse!
  end
  (options[:times]).times {puts string}
  nil
end