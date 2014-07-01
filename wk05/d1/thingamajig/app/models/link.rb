# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  url        :string(1024)     not null
#  created_at :datetime
#  updated_at :datetime
#

class Link < ActiveRecord::Base
  validates :post, :url, presence: true
  
  belongs_to(
    :post, 
    class_name: "Post", 
    foreign_key: :post_id, 
    primary_key: :id,
    inverse_of: :links
  )
  
end
