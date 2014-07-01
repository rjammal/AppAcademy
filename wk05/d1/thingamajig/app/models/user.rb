# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  MIN_PASSWORD_LENGTH = 8

  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password_length, numericality: { greater_than_or_equal_to: MIN_PASSWORD_LENGTH,
                                              allow_nil: true }
  before_validation :new_user_session_token

  has_many(
    :circles,
    class_name: 'Circle',
    foreign_key: :owner_id,
    primary_key: :id
  )
  
  has_many(
    :circle_memberships,
    class_name: 'CircleMembership',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :encircling_circles, 
    through: :circle_memberships, 
    source: :circle 
  )
  
  has_many(
    :feed_posts,
    through: :encircling_circles,
    source: :posts
  )
    
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end
  
  def password=(password)
    @password_length = password.length
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def password
    BCrypt::Password.new(password_digest)
  end
  
  def self.find_by_credentials(email, password)
    u = User.find_by_email(email)
    return nil unless u
    u if u.password == password
  end
  
  private 
  def new_user_session_token
    self.session_token ||= User.generate_session_token
  end
  
  attr_reader :password_length
  
end
