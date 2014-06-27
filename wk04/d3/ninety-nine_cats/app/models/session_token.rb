class SessionToken < ActiveRecord::Base
  validates :user_id, :session_token, presence: true
  validates :session_token, uniqueness: true
  
  belongs_to(:user)
  
  
  def self.users_session_tokens(user_id)
    SessionToken.where(user_id: user_id)
  end
  
  def self.create_for_user!(user)
    SessionToken.create(user_id: user.id, 
      session_token: SecureRandom::urlsafe_base64)
  end
  
end