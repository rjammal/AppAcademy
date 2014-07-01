# == Schema Information
#
# Table name: circle_memberships
#
#  id         :integer          not null, primary key
#  circle_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class CircleMembership < ActiveRecord::Base
  validates :circle, :user_id, presence: true
  #validates :circle_id, uniqueness: {scope: :user_id}
  
  belongs_to(
    :circle,
    class_name: 'Circle',
    foreign_key: :circle_id,
    primary_key: :id,
    inverse_of: :circle_memberships
  )
  
  belongs_to(
    :member,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  
end
