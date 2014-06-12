class XmlDocument
  def initialize(indented = false)
    @indented = indented
    @depth = 1
  end

  def method_missing(*name, &prc) 
    method_name = name[0]

    if @indented
      newline = "\n"
      start_indent = "  " * @depth
      end_indent = "  " * (@depth - 1)
      
    else
      newline = ""
      start_indent = ""
      end_indent = ""
    end

    if !prc.nil?
      @depth += 1
      result = "<#{method_name}>#{newline}#{start_indent}#{prc.call}#{newline}#{end_indent}</#{method_name}>"
      @depth -= 1
      result << newline if @depth == 1
      result
    elsif name.length == 1
      "<#{method_name}/>"
    elsif name[1].class == Hash
      attributes = name[1]
      tag = attributes.keys[0]
      "<#{method_name} #{tag}='#{attributes[tag]}'/>"
    end
  end
end