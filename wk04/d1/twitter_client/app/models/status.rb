require 'open-uri'

class Status < ActiveRecord::Base
  validates :body, :twitter_status_id, :twitter_user_id, presence: true 
  validates :twitter_status_id, uniqueness: true
  belongs_to(
    :user, 
    primary_key: :twitter_user_id, 
    foreign_key: :twitter_user_id
    )

  def self.fetch_by_twitter_user_id!(twitter_user_id)
    raw = TwitterSession.get('statuses/user_timeline', user_id: twitter_user_id)
    statuses = JSON.parse(raw)
    previous_saved_tweets = Status.all.where(twitter_user_id: twitter_user_id).pluck(:twitter_status_id)
    statuses.each do |stat_hash|
      s = parse_json(stat_hash)
      next if previous_saved_tweets.include?(s.twitter_status_id)
      s.save!
    end
  end

  def self.parse_json(status_hash)
    s = Status.new()
    s.body = status_hash["text"]
    s.twitter_status_id = status_hash["id_str"]
    s.twitter_user_id = status_hash["user"]["id_str"]
    s
  end

  def self.post(body)
    raw = JSON.parse(TwitterSession.post('statuses/update', status: body))
    new_status = parse_json(raw)
    puts new_status
    new_status.save!
  end

  def self.get_by_twitter_user_id(user_id)
    if internet_connection?
      fetch_by_twitter_user_id!(user_id)
    else
      Status.where(twitter_user_id: user_id)
    end
  end


end

def internet_connection?
  begin
    true if open("http://www.google.com")
  rescue SocketError
    false
  end
end
