class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials( session_params[:email], 
                                      session_params[:password])
    if @user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(session_params)
      flash.now[:errors] = ["Unable to look up user. Please try your credentials again."]
      render 'new'
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

  def new
    @user = User.new
    render 'new'
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end

end