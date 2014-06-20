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
  
  def most_popular_urls

    ShortenedURL.find_by_sql(<<-SQL
    SELECT 
      url.long_url, COUNT(*) num_visits 
    FROM 
      tag_topics topics
    JOIN 
      taggings tags ON tags.tag_topic_id = topics.id
    JOIN 
      shortened_urls url ON url.id = tags.short_url_id
    JOIN 
      visits visit ON visit.short_url_id = url.id
    WHERE 
      topics.topic = '#{self.topic}'
    GROUP BY 
      url.long_url
    ORDER BY 
      num_visits desc
    LIMIT 5;
    
    SQL
    )
  end

  def most_popular_urls_active_record
    popular_urls = TagTopic.joins(shortened_urls: :visits)
      .where(["tag_topics.topic = ?", self.topic])
      .group("shortened_urls.long_url")
      .order("COUNT(*) DESC")
      .select("tag_topics.*, shortened_urls.long_url AS url, COUNT(*) AS num_visits")
      .take(5)
    
    result = {}
    popular_urls.each { |tag| result[tag.url] = tag.num_visits }
    result 
  end
  
end