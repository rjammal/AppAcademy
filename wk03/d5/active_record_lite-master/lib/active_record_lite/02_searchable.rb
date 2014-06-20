require_relative 'db_connection'
require_relative '01_sql_object'
require 'debugger'

module Searchable
  def where(params)
    column_names = params.keys.map {|col| "#{col} = ?"}.join(" AND ")
    result = DBConnection.execute(<<-SQL, *params.values)
    SELECT 
      *
    FROM
      #{table_name}
    WHERE
      #{column_names}
    SQL
    parse_all(result)
  end
end

class SQLObject
  extend Searchable
end
