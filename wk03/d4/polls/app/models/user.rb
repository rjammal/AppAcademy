# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
  
  has_many(
    :polls, 
    class_name: 'Poll',
    foreign_key: :author_id, 
    primary_key: :id
  )
  
  has_many(
    :responses, 
    class_name: 'Response', 
    foreign_key: :user_id, 
    primary_key: :id
  )
  
  def completed_polls
    polls_response_count = responses_per_poll
    questions_per_poll = polls_with_question_count(polls_response_count.keys)
    
    completed_polls_result = []
    
    questions_per_poll.each do |poll|
      total_questions = poll.questions_per_poll      
      if polls_response_count[poll.id] == total_questions
        completed_polls_result << poll
      end
      
    end
    
    completed_polls_result
  end
  
  def uncompleted_polls
    polls_response_count = responses_per_poll
    questions_per_poll = polls_with_question_count(polls_response_count.keys)
    
    uncompleted_polls_result = []
    
    questions_per_poll.each do |poll|
      total_questions = poll.questions_per_poll      
      if polls_response_count[poll.id] != total_questions
        uncompleted_polls_result << poll
      end
    end
    
    uncompleted_polls_result
  end
  
  private 
  def responses_per_poll
    user_response_counts = responses.joins(answer_choice: [question: :poll])
        .select("COUNT(*) AS num_responses, polls.id AS poll_id")
        .group("polls.id")

    polls_response_count = {} 

    user_response_counts.each do |response|
      polls_response_count[response.poll_id] = response.num_responses
    end
    
    polls_response_count
  end
  
  def polls_with_question_count(poll_id_arr)
    Poll.joins(:questions)
      .where(["questions.poll_id IN (?)",poll_id_arr])
      .group("questions.poll_id")
      .select("polls.*, COUNT(*) AS questions_per_poll")
  end
  
end
