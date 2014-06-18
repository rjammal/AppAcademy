require './QuestionsDatabase'
require './Question'
require './QuestionFollower'
require './QuestionLike'
require './Reply'
require './Saveable'


class User
  include Saveable
  TABLE = "whatever"
  
  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, id).last
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL
    
    User.new(result)
  end
  
  def self.find_by_name(fname, lname)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, fname, lname).last
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL
    
    User.new(result)
  end
  
  attr_accessor :fname, :lname
  
  def initialize(opts = {})
    @id    = opts['id']
    @fname = opts['fname']
    @lname = opts['lname']
  end
  
  
  def authored_questions
    Question.find_by_author_id(@id)
  end
  
  def authored_replies
    Reply.find_by_user_id(@id)
  end
  
  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end
  
  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end
  
  def avg_karma
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, @id)
    SELECT
      CAST(COUNT(l.id) as FLOAT) / COUNT(DISTINCT q.id) as avg_karma
    FROM
      questions q
    LEFT JOIN
      question_likes l ON q.id = l.question_id
    WHERE
      q.author_id = ?
    SQL
    
    result.last['avg_karma']
  end
  
end

if __FILE__ == $PROGRAM_NAME
  # rosemary = User.find_by_id(1)
  # marco = User.find_by_id(2)
  # andrew = User.find_by_id(3)
  # # p User.find_by_id(2)
  # # p User.find_by_name('Rosemary', 'Jammal')
  # # p rosemary.authored_replies
  # # p marco.authored_replies
  # # p rosemary.followed_questions
  # # p rosemary.liked_questions
  # p marco.avg_karma
  # p rosemary.avg_karma
  # p andrew.avg_karma
  u = User.new('fname' => 'mickey', 'lname' => 'mouse')
  u.save
  p u
  u.fname = 'c'
  u.save
  p u
end