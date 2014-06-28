module SessionsHelper

  def log_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out! 
    current_user.reset_session_token!
    session[:session_token] = nil
  end
end