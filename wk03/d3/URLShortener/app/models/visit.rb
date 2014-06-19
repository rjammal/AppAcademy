class Visit < ActiveRecord::Base
  validates :submitter_id, :short_url_id, presence: true
  
  belongs_to(
    :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: 'User'
  )
  
  belongs_to(
    :short_url,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: 'ShortenedURL'
  )
  
  def self.record_visit!(user, shortened_url)
    Visit.create!({submitter_id: user.id, short_url_id: shortened_url.id})
  end
      

  
end