class SessionsController < ApplicationController
  
  before_action :view_cats_if_logged_in, except: :destroy
  
  def new
    @user = User.new
    
    render :new
  end
  
  def create
    @user = User.find_by_credentials(session_params[:user_name], 
                                     session_params[:password])
    
    if @user.nil?
      @user = User.new(session_params)
      flash.now[:errors] = "User not found."
      render :new
    else
      log_in!(@user)
      redirect_to cats_url
    end
  end
  
  def destroy
    log_out!
    redirect_to new_session_url
  end
  
  private
  def session_params
    params.require(:user).permit(:user_name, :password)
  end
end