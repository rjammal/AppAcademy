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
  attr_reader :password
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}
  before_validation :ensure_session_token

  has_many :notes, dependent: :destroy

  def self.find_by_credentials(user_email, pword)
    user = find_by_email(user_email)
    return nil if user.nil?

    if user.is_password?(pword)
      user
    else
      nil
    end
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def is_password?(secret)
    bcrypt = BCrypt::Password.new(password_digest)
    bcrypt.is_password?(secret)
  end

  def password=(pword)
    @password = pword 
    self.password_digest = BCrypt::Password.create(pword)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    save!
  end

end
