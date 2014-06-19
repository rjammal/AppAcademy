class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  
  has_many(
    :submitted_urls,
    class_name: 'ShortenedURL',
    primary_key: :id,
    foreign_key: :submitter_id
  )
  
  has_many(
    :visits, 
    class_name: "Visit", 
    primary_key: :id, 
    foreign_key: :submitter_id
  )
  
  has_many(
    :visited_urls, 
    class_name: "ShortenedURL", 
    through: :visits, 
    source: :short_url
  )

end