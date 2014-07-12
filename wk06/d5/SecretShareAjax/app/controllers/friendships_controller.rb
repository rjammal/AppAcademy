class FriendshipsController < ApplicationController
  
  def create
    sleep(2)
    friendship = Friendship.new(out_friend_id: current_user.id,
                                 in_friend_id: params[:user_id])                       
    if friendship.save
      render json: friendship.id, status: 200
    else
      render json: friendship.errors.full_messages, status: 422
    end
    
  end
  
  def destroy
    sleep(2)
    Friendship.find(params[:id]).destroy
    head :ok
  end
  
end