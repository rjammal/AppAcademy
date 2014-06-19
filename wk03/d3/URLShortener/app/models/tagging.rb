class Tagging < ActiveRecord::Base

  validates :tag_topic_id, :short_url_id, :presence => true

  belongs_to(
    :tag_topic,
    primary_key: :id, 
    foreign_key: :tag_topic_id,
    class_name: 'TagTopic'
  )
  
  belongs_to(
    :short_url,
    primary_key: :id, 
    foreign_key: :short_url_id,
    class_name: 'ShortenedURL'
  )

  def self.create_from_tag_and_url!(tag, url)
    create!(tag_topic_id: tag.id, short_url_id: url.id)
  end
end