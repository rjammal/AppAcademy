class UsersController < ApplicationController
  
  before_action :view_cats_if_logged_in
  
  def new
    @u = User.new
     
    render :new
  end
  
  def create
    @u = User.new(user_params)
    if @u.save
      log_in!(@u)
      redirect_to cats_url
    else
      flash.now[:errors] = @u.errors.full_messages
      render 'new'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
  
end