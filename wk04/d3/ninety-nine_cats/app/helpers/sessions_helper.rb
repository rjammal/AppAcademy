module SessionsHelper
  def current_user
    token = SessionToken.find_by_session_token(session[:session_token])
    User.find(token.user_id) unless token.nil?
  end
  
end