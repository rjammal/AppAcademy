class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      ivar_name = "@#{name}"
      #getters
      define_method "#{name}" do
        instance_variable_get ivar_name
      end
      #setters
      define_method "#{name}=" do |value|
        instance_variable_set ivar_name, value
      end
    end
  end
end
