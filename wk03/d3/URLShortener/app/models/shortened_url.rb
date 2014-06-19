class ShortenedURL < ActiveRecord::Base
  

  validates :short_url, uniqueness: true
  validates :long_url, :short_url, :submitter_id, presence: true
  
  def self.random_code
    # get first 16 characters
    code = SecureRandom::urlsafe_base64[0...16]
    until ShortenedURL.where("short_url = '#{code}'").empty?
      code = SecureRandom::urlsafe_base64[0...16]
    end
    code
  end
  
  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedURL.create!({submitter_id: user.id, long_url: long_url, 
      short_url: random_code})
  end
  
  belongs_to(
   :submitter,
   primary_key: :id,
   foreign_key: :submitter_id,
   class_name: "User"
  )
  
  has_many(
    :visits, 
    class_name: "Visit", 
    primary_key: :id, 
    foreign_key: :short_url_id
  )
  
  has_many(
    :visitors, 
    -> {uniq}, 
    class_name: "User", 
    through: :visits, 
    source: :submitter
  )
  
  has_many(
    :taggings,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: 'Tagging'
  )
  
  has_many(
   :topics,
   through: :taggings,
   source: :tag_topic
   )
  
  def num_clicks
    visits.count
  end
  
  def num_uniques
    visitors.count
  end
  
  def num_recent_uniques
    visitors.where("visits.created_at > '#{10.minutes.ago}'").count
  end

end