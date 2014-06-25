class User < ActiveRecord::Base
  validates :screen_name, :twitter_user_id, presence: true, uniqueness: true 
  has_many(
    :statuses, 
    primary_key: :twitter_user_id, 
    foreign_key: :twitter_user_id
    )

  has_many(
    :outbound_follows, 
    primary_key: :twitter_followee_id, 
    foreign_key: :twitter_user_id, 
    class_name: "Follow"
    )

  has_many(
    :inbound_follows, 
    primary_key: :twitter_follower_id,
    foreign_key: :twitter_user_id,
    class_name: "Follow"
    )

  has_many(
    :followers, 
    through: :inbound_follows, 
    source: :follower
    )

  has_many(
    :followees, 
    through: :outbound_follows, 
    source: :followee
    )

  def self.fetch_by_user_name!(name)
    db_users = User.where(screen_name: name.downcase)
    if db_users.empty?
      u = parse_twitter_user(TwitterSession.get('users/show', screen_name: name))
      u.save!
      u
    else
      db_users.first
    end
  end

  def self.get_by_screen_name(name)
    fetch_by_user_name!(name)
  end

  def self.parse_twitter_user(json_user)
    raw = JSON.parse(json_user)
    u = User.new
    u.screen_name = raw["screen_name"].downcase
    u.twitter_user_id = raw["id"]
    u
  end

  def fetch_statuses!
    Status.fetch_by_twitter_user_id!(twitter_user_id)
  end

end
