class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :null_session
  
  def log_in!(user)
    token = SessionToken.create_for_user!(user)
    session[:session_token] = token.session_token
  end
  
  def log_out!
    token = SessionToken.find_by_session_token(session[:session_token])
    token.destroy
    session[:session_token] = nil
  end
  
  def view_cats_if_logged_in
    if current_user
      redirect_to cats_url
    end
  end
end
