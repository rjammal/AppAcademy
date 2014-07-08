require 'active_support/inflector'

module URLHelper

  def create_url_helper(route)

    name, main, param, modifier = method_name_and_args(route.pattern)
    puts name
    if param 
      define_method(name) do |arg|
        ["", main.singularize, arg, modifier].compact.join("/")
      end
    else
      define_method(name) do 
        ["", main, modifier].compact.join("/")
      end
    end
  end



  def method_name_and_args(regex)
    reg_str = regex.inspect[1..-2] #remove slashes round regex
    reg_str = remove_special_chars(reg_str)
    component_array = reg_str.split("/")
    non_param_regex = /^(\w+)$/
    param_regex = /^\(\?<(.+)>.+\)$/
    main = nil
    param = nil
    modifier = nil
    component_array.each_with_index do |name, i|
      next if i == 0 # first element is ^ - ignore
      if i == 1
        main = non_param_regex.match(name)[0]
      elsif param_regex.match(name) && param.nil? 
        param = param_regex.match(name)[1]
      elsif non_param_regex.match(name) && modifier.nil?
        modifier = non_param_regex.match(name)[0]
      end
    end
    p_name = param_name(param)
    main_name = param ? main.singularize : main
    method_name = [modifier, p_name, main_name, "url"].compact.join("_")
    [method_name, main, param, modifier]
  end

  def remove_special_chars(str)
    special_chars = ["\\", "$", "^"]
    special_chars.each do |char|
      str = str.gsub(char, "")
    end
    str
  end

  def param_name(param_str)
    if param_str == "id" || param_str.nil?
      nil
    else
      param_str.sub("_id", "")
    end
  end
end