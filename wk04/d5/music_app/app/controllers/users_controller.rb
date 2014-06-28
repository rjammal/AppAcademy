class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render 'new'
    end
  end

  def destroy
  end

  def edit
  end

  def index
  end

  def new 
    @user = User.new
    render 'new'
  end

  def show
    @user = User.find(params[:id])
    render 'show'
  end

  def update
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end