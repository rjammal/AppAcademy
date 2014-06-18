require './QuestionsDatabase.rb'
require './User.rb'
require './Saveable'

class Reply
  include Saveable
  TABLE = "whatever"
  
  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, id).last
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL
    
    Reply.new(result) if result
  end
  
  def self.find_by_question_id(id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      subject_question_id = ?
    SQL
    
    result.map { |hash| Reply.new(hash) }
  end
  
  def self.find_by_user_id(id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      author_id = ?
    SQL
    
    result.map { |hash| Reply.new(hash) }
  end
  
  def self.find_by_parent_id(id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_reply_id = ?
    SQL
    
    result.map { |hash| Reply.new(hash) }
  end
  
  attr_accessor :subject_question_id, :author_id, :parent_reply_id, :body
  
  def initialize(opts = {})
    @id                   = opts['id']
    @subject_question_id  = opts['subject_question_id']
    @parent_reply_id      = opts['parent_reply_id']
    @author_id            = opts['author_id']
    @body                 = opts['body']
  end
  
  def author
    User.find_by_id(@author_id)
  end
  
  def question
    Question.find_by_id(@subject_question_id)
  end
  
  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end
  
  def child_replies
    Reply.find_by_parent_id(@id)
  end
end

if __FILE__ == $PROGRAM_NAME
  # p Reply.find_by_id(1)
  x = Reply.find_by_id(2)
  # p x.question
  # p x.parent_reply
  y = Reply.find_by_id(3)
  # p y.parent_reply
  p x.child_replies
  p y.child_replies
end