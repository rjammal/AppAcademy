class UsersController < ApplicationController
  def index
    render json: User.all
  end
  
  def show
    user = User.find(params[:id])
    render json: user
  end
  
  def update
    user = User.find(params[:id])
    
    if user.update_attributes(user_params)
      render :json => user
    else
      render :json => user.errors.full_messages, status: 422
    end
  end
  
  def create
    user = User.new(user_params)
    
    if user.save
      render :json => user
    else
      render :json => user.errors.full_messages, status: 422
    end
  end
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    render :json => user
  end
  
  def favorites
    render json: Contact.contacts_for_user_id(params[:id])
      .where("(contacts.favorite = ? AND contacts.user_id = ?) OR
              (share_fave = ? AND contacts.user_id != ?)", 
              true, params[:id], true, params[:id])
  end
  
  
  
  private
  def user_params
    params[:user].permit(:username)
  end
  
end
