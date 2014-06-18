require './QuestionsDatabase'
require 'active_support/inflector'

module Saveable
  def save
    db = QuestionsDatabase.instance
    # execute_string = 
    vars = self.instance_variables
    # removing the leading @
    ivar_names = vars.map { |method| method[1..-1] }
    ivar_names.delete("id")

    ivar_values = ivar_names.map { |iname| self.send(iname) }
    
    table_name = self.class.to_s.downcase.pluralize
    
    if @id.nil?
      db.execute(<<-SQL, *ivar_values)
      INSERT INTO
        #{table_name} (#{ivar_names.join(", ")})
      VALUES
        (#{(['?'] * ivar_names.count).join', '})
      SQL

      @id = db.last_insert_row_id
    else
      db.execute(<<-SQL, *ivar_values, @id)
      UPDATE
        #{table_name}
      SET
        #{ivar_names.map { |name| "#{name} = ?" }.join(", ")}
      WHERE
        id = ?
      SQL
    end
  end
end