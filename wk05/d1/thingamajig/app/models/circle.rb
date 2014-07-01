# == Schema Information
#
# Table name: circles
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  owner_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Circle < ActiveRecord::Base
  validates :name, :owner_id, presence: true
  
  belongs_to(
    :owner,
    class_name: 'User',
    foreign_key: :owner_id,
    primary_key: :id
  )
  
  has_many(
    :circle_memberships,
    class_name: 'CircleMembership',
    foreign_key: :circle_id,
    primary_key: :id,
    inverse_of: :circle,
    dependent: :destroy
  )
  
  has_many(
    :members,
    through: :circle_memberships,
    source: :member
  )
  
  has_many(
    :post_shares, 
    foreign_key: :circle_id, 
    primary_key: :id, 
    class_name: "PostShare"
  )
  
  has_many(
    :posts, 
    through: :post_shares, 
    source: :post
  )
end
