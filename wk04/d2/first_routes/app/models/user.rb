# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :username, presence: true
  validate :username, uniqueness: true
  
  has_many(:contacts)
  
  has_many :contact_shares
  
  has_many :shared_contacts,
    through: :contact_shares,
    source: :contact
  
  has_many :comments, as: :commentable
end
