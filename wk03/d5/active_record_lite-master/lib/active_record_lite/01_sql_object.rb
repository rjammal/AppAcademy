require_relative 'db_connection'
require 'active_support/inflector'
require 'debugger'
#NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
#    of this project. It was only a warm up.

class SQLObject
  def self.columns
    column_names = DBConnection.execute2("select * from #{table_name}")[0]
    column_names.map! { |column| column.to_sym }
    column_names.each do |col|
      #getter
      define_method(col.to_s) do 
        attributes[col]
      end
      #setter
      define_method(col.to_s + "=") do |value|
        attributes[col] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.underscore.pluralize
  end

  def self.all
    sql = <<-SQL
    SELECT 
      #{table_name}.*
    FROM 
      #{table_name}
    SQL
    parse_all(DBConnection.execute(sql))
  end
  
  def self.parse_all(results)
    results.map { |hash| self.new(hash) }
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id)
    SELECT 
      #{table_name}.*
    FROM 
      #{table_name}
    WHERE
      #{table_name}.id = ?
    SQL
    self.new(result[0])
  end

  def attributes
    @attributes ||= {}
  end


  def insert
    table_name = self.class.table_name
    columns = attributes.keys
    col_names = columns.join(", ")
    question_marks = (["?"] * columns.length).join(", ")
    DBConnection.execute(<<-SQL, *attribute_values)
    INSERT INTO 
      #{table_name} (#{col_names})
    VALUES 
      (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def initialize(params = {})
    columns = self.class.columns 
    params.each do |attr_name, value| 
      attr_sym = attr_name.to_sym
      if !columns.include?(attr_sym)
        raise "unknown attribute '#{attr_name}'"
      end
      self.send("#{attr_name}=", value)
    end
  end

  def save
    if id.nil?
      insert
    else
      update
    end
  end

  def update
    columns = attributes.keys.map { |col| "#{col} = ?" }
    column_names = columns.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values, id)
    UPDATE 
      #{self.class.table_name}
    SET 
      #{column_names}
    WHERE
      id = ?
    SQL
  end

  def attribute_values
    attributes.keys.map { |method| self.send(method) }
  end
end

