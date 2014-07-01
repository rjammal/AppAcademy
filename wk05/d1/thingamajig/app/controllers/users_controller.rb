class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      log_in!(user)
      redirect_to circles_url
    else
      @user = user
      flash.now[:errors] = user.errors.full_messages
      render 'new'
    end
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end
  
  def update
    user = current_user # why are you such a defensive coder, rosemary?
    if user.update_attributes(user_params)
      redirect_to user_url(user)
    else
      @user = user
      flash.now[:errors] = user.errors.full_messages
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
  
end