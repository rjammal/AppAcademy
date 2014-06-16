
class Student
  
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end
  
  def name 
    "#{@first_name} #{@last_name}"
  end
  
  def courses
    @courses
  end
  
  def enroll course
    @courses.each do |existing_course|
      if existing_course.conflicts_with? course
        print "sorry the course conflicts with #{existing_course.course_name}"
        return
      end
    end
    if !@courses.include?(course)
      @courses << course
      course.add_student(self)
    else
      puts "Already enrolled!"
    end
  end
  
  def course_load
    result = Hash.new(0)
    @courses.each do |course|
      result[course.dept] += course.num_credits
    end
    result
  end
  
end

class Course
  
  attr_reader :course_name, :dept, :num_credits, :days, :time
  attr_accessor :students
  
  def initialize(course_name, dept, num_credits, days, time)
    @course_name = course_name
    @dept = dept
    @num_credits = num_credits
    @students = []
    @days = days
    @time = time
  end
  
  def add_student(student)
    @students << student unless @students.include? (student)
    student.enroll(self) unless student.courses.include? (self)
  end
  
  def conflicts_with?(other_course)
    if self.time == other_course.time 
      @days.each do |day|
        if other_course.days.include? day
          return true
        end
      end
    end
    false
  end
  
  
    
  
end