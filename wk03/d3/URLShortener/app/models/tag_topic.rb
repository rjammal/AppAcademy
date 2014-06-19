class TagTopic < ActiveRecord::Base
  
  validates :topic, presence: true
  
  has_many(
    :taggings,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: 'Tagging'
  )
  
  has_many(
    :shortened_urls,
    through: :taggings,
    source: :short_url
  )
  
  has_many(
    :visits, 
    through: :taggings, 
    source: :short_url
  )
  
  def most_popular

    ShortenedURL.find_by_sql(<=SQL
    SELECT * FROM tag_topics
    
    SQL
    )
  end
  
end