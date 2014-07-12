# == Schema Information
#
# Table name: friendships
#
#  id            :integer          not null, primary key
#  out_friend_id :integer          not null
#  in_friend_id  :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Friendship < ActiveRecord::Base
  
  validates :out_friend_id, :in_friend_id, presence: true
  validates :out_friend_id, uniqueness: { scope: :in_friend_id }
  
  belongs_to(
  :out_friend, 
  class_name: "User", 
  foreign_key: :out_friend_id
  )
  
  belongs_to(
  :in_friend, 
  class_name: "User", 
  foreign_key: :in_friend_id
  )
  
end
