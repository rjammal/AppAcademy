# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  text        :string(1024)     not null
#  created_at  :datetime
#  updated_at  :datetime
#

class AnswerChoice < ActiveRecord::Base
  validates :question_id, :text, presence: true
  before_destroy :delete_responses
  
  belongs_to(
    :question, 
    class_name: 'Question', 
    foreign_key: :question_id, 
    primary_key: :id
  )
  
  has_many(
    :responses, 
    class_name: 'Response', 
    foreign_key: :answer_id, 
    primary_key: :id
  )
  
  def self.create_by_question_and_text!(question, text)
    AnswerChoice.create!(question_id: question.id, text: text)
  end
  
  def delete_responses
    Response.destroy(responses.map {|response| response.id})
  end
end
