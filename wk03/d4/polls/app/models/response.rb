# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  answer_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_the_author_of_poll
  
  belongs_to(
    :answer_choice, 
    class_name: 'AnswerChoice', 
    foreign_key: :answer_id, 
    primary_key: :id
  )
  
  belongs_to(
    :respondent, 
    class_name: 'User', 
    foreign_key: :user_id, 
    primary_key: :id
  )
  
  def self.create_by_user_and_answer!(user, answer)
    Response.create!(user_id: user.id, answer_id: answer.id)
  end
  
  def question
    self.answer_choice.question
  end
  
  def respondent_has_not_already_answered_question
    existing_response_ids = existing_responses
    if existing_response_ids.length > 1
      errors[:user_id] << "bad data"
    elsif existing_response_ids.length == 1 && existing_response_ids.first != id
      errors[:user_id] << "a user can't have multiple response"
    end
        
  end
  
  def respondent_is_not_the_author_of_poll
    if question.poll.author.id == self.user_id
      errors[:user_id] << "You cannot respond to your own poll."
    end
  end
  
  private 
  def existing_responses
    Response.find_by_sql([<<-SQL, self.question.id, self.user_id])
      SELECT
        r.id
      FROM
        responses r
      JOIN
        answer_choices a ON r.answer_id = a.id
      JOIN
        questions q ON a.question_id = q.id
      WHERE
        q.id = (?) AND r.user_id = (?)
      SQL
  end
  
end
