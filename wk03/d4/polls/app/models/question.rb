# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer          not null
#  text       :string(1024)     not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true

  before_destroy :delete_answers
  
  belongs_to(
    :poll, 
    class_name: 'Poll', 
    foreign_key: :poll_id, 
    primary_key: :id
  )
  
  has_many(
    :answer_choices, 
    class_name: 'AnswerChoice', 
    foreign_key: :question_id, 
    primary_key: :id
  )
  
  has_many :responses, :through => :answer_choices, :source => :responses
  
  def self.create_by_poll_and_text!(poll, text)
    Question.create!(poll_id: poll.id, text: text)
  end
  
  def results
    answer_count = answer_choices
        .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_id")
        .group("answer_choices.id")
        .select("answer_choices.text, COUNT(responses.id) AS num_responses")

    answer_with_count = {}  
    answer_count.each do |answer|
      answer_with_count[answer.text] = answer.num_responses
    end        
    answer_with_count
  end
  
  def delete_answers
    AnswerChoice.destroy(answer_choices.map {|answer| answer.id})
  end
end
