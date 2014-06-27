# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password
  validates :user_name, :password_digest, :session_token, presence:true
  validates :password, length: { minimum: 6, allow_nil: true}
  
  before_validation :ensure_session_token
  has_many :cats
  has_many :cat_rental_requests
  has_many :session_tokens
  
  def self.find_by_credentials(user_name, password)
    u = User.find_by_user_name(user_name)
    if !u.nil?
      return u if u.is_password?(password)
    end
    nil
  end
  
  def ensure_session_token
    if SessionToken.users_session_tokens(id).empty?
      SessionToken.create(user_id: id, session_token: SecureRandom::urlsafe_base64)
    end
  end
  
  
  def is_password?(password)
    bcrypt_o = BCrypt::Password.new(self.password_digest)
    bcrypt_o.is_password?(password)
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  # def reset_session_token!
  #   self.session_token = SecureRandom::urlsafe_base64
  #   self.save!
  # end
  
end
