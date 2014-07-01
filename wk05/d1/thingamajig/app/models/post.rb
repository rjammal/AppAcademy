# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  author_id  :integer          not null
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :author_id, presence: true
  
  belongs_to(
    :author,
    foreign_key: :author_id, 
    primary_key: :id, 
    class_name: "User"
  )
  
  has_many(
    :links,
    class_name: "Link",
    foreign_key: :post_id,
    primary_key: :id, 
    inverse_of: :post,
    dependent: :destroy
  )
  
  has_many(
    :post_shares,
    class_name: "PostShare",
    foreign_key: :post_id,
    primary_key: :id, 
    inverse_of: :post,
    dependent: :destroy
  )
  
  has_many(
    :circles, 
    through: :post_shares, 
    source: :circle
  )
  
  
end
