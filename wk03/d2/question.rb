require './QuestionsDatabase.rb'
require './User.rb'
require './Saveable'

class Question
  include Saveable
  
  def self.find_by_id(id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, id).last
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL
    
    Question.new(result)
  end
  
  def self.find_by_title(title)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, title).last
    SELECT
      *
    FROM
      questions
    WHERE
      title = ?
    SQL
    
    Question.new(result)
  end
  
  def self.find_by_author_id(id)
    db = QuestionsDatabase.instance
    result = db.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = ?
    SQL
    
    result.map { |hash| Question.new(hash) }
  end
  
  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end
  
  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
  
  attr_accessor :title, :body, :author_id
  
  def initialize(opts = {})
    @id        = opts['id']
    @title     = opts['title']
    @body      = opts['body']
    @author_id = opts['author_id']
  end
  
  def author
    User.find_by_id(@author_id)
  end
  
  def replies
    Reply.find_by_question_id(@id)
  end
  
  def followers
    QuestionFollower.followers_for_question_id(@id)
  end
  
  def likers
    QuestionLiker.likers_for_question_id(@id)
  end
  
  def num_likes
    QuestionLiker.num_likes_for_question_id(@id)
  end
end

if __FILE__ == $PROGRAM_NAME
  q = Question.new('title' => 'Is anyone out there?',
                   'body' => 'Can anyone be?',
                   'author_id' => 1)
  p q
  q.save
  p q
  # p q.author
  # p q.replies
  # p q.followers
end