
class Employee
  attr_accessor :name, :title, :salary, :boss
  
  def bonus(multiplier)
    salary * multiplier
  end
  
end

class Manager < Employee
  
  def initialize(employees)
    @employees = employees
  end
  
  def bonus(multiplier)
    total_sub_salary * multiplier
  end
  
  protected
  
  def total_sub_salary
    result = 0
    @employees.each do |employee|
      if employee.is_a?(Manager)
        result += employee.total_sub_salary
      end
      result += employee.salary
    end
    result
  end
end