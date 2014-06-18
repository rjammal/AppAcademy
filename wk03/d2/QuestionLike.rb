require './QuestionsDatabase.rb'
require './User'

class QuestionLike
  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    question_like_hash = db.execute(<<-SQL, id).last
    SELECT
      *
    FROM
      question_likes
    WHERE
      id = ?
    SQL
    
    QuestionLike.new(question_like_hash)
  end
  
  
  def self.find_by_user_id(id)
    db = QuestionsDatabase.instance
    question_like_hash = db.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE
      user_id = ?
    SQL
    
    QuestionLike.new(question_like_hash)
  end
  
  def self.likers_for_question_id(id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, id)
    SELECT
      users.*
    FROM
      question_likes likes
    JOIN
      users ON users.id = likes.user_id
    WHERE
      question_id = ?
    SQL
    
    result.map { |hash| User.new(hash) }
  end
  
  def self.num_likes_for_question_id(id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, id).last
    SELECT
      count(*) num_likes
    FROM
      question_likes
    WHERE
      question_id = ?
    SQL
    
    result['num_likes']
  end
  
  def self.liked_questions_for_user_id(user_id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, user_id)
    SELECT
      q.*
    FROM
      question_likes l
    JOIN
      questions q ON l.question_id = q.id
    WHERE
      l.user_id = ?
    SQL
    
    result.map { |hash| Question.new(hash) }
  end
  
  def self.most_liked_questions(n)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, n)
    select 
      q.*
    FROM
      questions q
    JOIN
      question_likes l ON q.id = l.question_id
    GROUP BY 
      q.id, q.title, q.body, q.author_id
    ORDER BY COUNT(*) DESC
    LIMIT(?)
    SQL
    
    result.map { |hash| Question.new(hash) }
  end
  
  attr_accessor :question_id, :user_id
  
  def initialize(opts = {})
    @id           = opts['id']
    @question_id  = opts['question_id']
    @user_id      = opts['user_id']
  end
end

if __FILE__ == $PROGRAM_NAME
  # p QuestionLike.num_likes_for_question_id(2)
  p QuestionLike.most_liked_questions(2)
end