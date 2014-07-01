class SessionsController < ApplicationController
  
  def create
    user = User.find_by_credentials(session_params[:email], session_params[:password])
    if user
      log_in!(user)
      redirect_to circles_url
    else
      @user = User.new(session_params)
      flash.now[:errors] = ['wrong email or password']
      render 'new'
    end
  end
  
  def destroy
    log_out!
    redirect_to new_session_url
  end
  
  def new
    @user = User.new
  end
  
  private
  def session_params
    params.require(:user).permit(:email, :password)
  end

end