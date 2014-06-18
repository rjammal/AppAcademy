require './Question'
require './QuestionsDatabase'
require './User'
require 'debugger'

class QuestionFollower
  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    question_follower_hash = db.execute(<<-SQL, id).last
    SELECT
      *
    FROM
      question_followers
    WHERE
      id = ?
    SQL
    
    QuestionFollower.new(question_follower_hash)
  end
  
  def self.find_by_question_id(id)
    db = QuestionsDatabase.instance
    question_follower_hash = db.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_followers
    WHERE
      question_id = ?
    SQL
    
    QuestionFollower.new(question_follower_hash)
  end
  
  def self.find_by_follower_id(id)
    db = QuestionsDatabase.instance
    question_follower_hash = db.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_followers
    WHERE
      follower_id = ?
    SQL
    
    QuestionFollower.new(question_follower_hash)
  end
  
  def self.followers_for_question_id(id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, id)
    SELECT
      users.*
    FROM
      question_followers follow
    JOIN 
      users ON follow.follower_id = users.id
    WHERE
      question_id = ?
    SQL
    
    result.map { |hash| User.new(hash) }
  end
  
  def self.followed_questions_for_user_id(id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, id)
    SELECT
      q.*
    FROM
      question_followers follow
    JOIN 
      questions q ON follow.question_id = q.id
    WHERE
      follower_id = ?
    SQL
    
    result.map { |hash| Question.new(hash) }
  end
  
  def self.most_followed_questions(n)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, n)
    SELECT 
      question_id, COUNT(*) num_followers
    FROM 
      question_followers
    GROUP BY
      question_id
    ORDER BY
      num_followers DESC
    LIMIT(?)
    SQL
    
    result.map { |hash| Question.find_by_id(hash['question_id']) }
  end
  
  attr_accessor :question_id, :follower_id
  
  def initialize(opts = {})
    @id          = opts['id']
    @question_id = opts['question_id']
    @follower_id = opts['follower_id']
  end
end

if __FILE__ == $PROGRAM_NAME
  # p QuestionFollower.find_by_id(1)
  # p QuestionFollower.followers_for_question_id(1)
  #p QuestionFollower.followed_questions_for_user_id(1)
  p QuestionFollower.most_followed_questions(1)
  #p QuestionFollower.most_followed_questions(1)
end