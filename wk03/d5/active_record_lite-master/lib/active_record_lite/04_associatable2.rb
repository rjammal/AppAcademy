require_relative '03_associatable'

# Phase V
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    through_options = assoc_options[through_name]
    define_method name do
      source_options = through_options.model_class.assoc_options[source_name]
      result_table = source_options.table_name
      intermediate_table = through_options.table_name
      foreign_key_to_intermediate_table = self.send(through_options.foreign_key)
      raw = DBConnection.execute(<<-SQL, foreign_key_to_intermediate_table)
      SELECT 
        #{result_table}.*
      FROM
        #{result_table} 
      JOIN
        #{intermediate_table} ON 
          #{result_table}.id = #{intermediate_table}.#{source_options.foreign_key}
      WHERE
        #{intermediate_table}.id = ?
      SQL
      source_options.model_class.parse_all(raw)[0]
    end
  end

  def has_many_through(name, through_name, source_name)
    through_options = assoc_options[through_name]
    define_method name.to_s do
      source_options = through_options.model_class.assoc_options[source_name]
      result_table = source_options.table_name
      intermediate_table = through_options.table_name
      beginning_table = self.class.table_name
      filter = self.send(through_options.primary_key)

      raw = DBConnection.execute(<<-SQL, filter)
      SELECT 
        #{result_table}.*
      FROM
        #{result_table} 
      JOIN
        #{intermediate_table} ON 
          #{result_table}.#{source_options.primary_key} 
            = #{intermediate_table}.#{source_options.primary_key}
      WHERE
        #{intermediate_table}.#{through_options.foreign_key} = ?
      SQL
      source_options.model_class.parse_all(raw)
    end
  end
end

