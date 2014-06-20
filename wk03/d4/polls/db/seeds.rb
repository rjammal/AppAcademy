# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



ActiveRecord::Base.transaction do
  taylor = User.create!(:user_name => "taylor")
  rosemary = User.create!(:user_name => "rosemary")
  bob = User.create!(user_name: "bob")
  
  poll1 = Poll.create_poll_by_author!(taylor, "What do you think of SQL")
  poll2 = Poll.create_poll_by_author!(taylor, "best language ever")
  poll3 = Poll.create_poll_by_author!(rosemary, "Favorite colors")
  
  question1 = Question.create_by_poll_and_text!(poll1, "rate sql from 1 to 5")
  question2 = Question.create_by_poll_and_text!(poll1, "why so many CAPS?!?!?")
  question3 = Question.create_by_poll_and_text!(poll2, "favorite programming language?")
  question4 = Question.create_by_poll_and_text!(poll2, "favorite spoken language?")
  question5 = Question.create_by_poll_and_text!(poll3, "what's your favorite color?")

  answer1 = AnswerChoice.create_by_question_and_text!(question1, "1")
  answer2 = AnswerChoice.create_by_question_and_text!(question1, "2")
  answer3 = AnswerChoice.create_by_question_and_text!(question1, "3")
  answer4 = AnswerChoice.create_by_question_and_text!(question1, "4")
  answer5 = AnswerChoice.create_by_question_and_text!(question1, "5")
  answer6 = AnswerChoice.create_by_question_and_text!(question2, "because it's COOL")
  answer7 = AnswerChoice.create_by_question_and_text!(question2, "because it's readable")
  answer8 = AnswerChoice.create_by_question_and_text!(question3, "ruby")
  answer9 = AnswerChoice.create_by_question_and_text!(question3, "python")
  answer10 = AnswerChoice.create_by_question_and_text!(question3, "java")
  answer11 = AnswerChoice.create_by_question_and_text!(question4, "english")
  answer12 = AnswerChoice.create_by_question_and_text!(question4, "italian")
  answer13 = AnswerChoice.create_by_question_and_text!(question4, "chinese")
  answer14 = AnswerChoice.create_by_question_and_text!(question5, "red")
  answer15 = AnswerChoice.create_by_question_and_text!(question5, "blue")
  answer16 = AnswerChoice.create_by_question_and_text!(question5, "yellow")
  
  response1 = Response.create_by_user_and_answer!(bob, answer2)
  response2 = Response.create_by_user_and_answer!(bob, answer7)
  response3 = Response.create_by_user_and_answer!(taylor, answer15)
  response4 = Response.create_by_user_and_answer!(rosemary, answer5)
  response5 = Response.create_by_user_and_answer!(rosemary, answer10)
end