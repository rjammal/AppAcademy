class CommentsController < ApplicationController
  
  def index
    if params[:user_id]
      comments = Comment.where( commentable_id: params[:user_id], 
                                commentable_type: "user")
    elsif params[:contact_id]
      comments = Comment.where( commentable_id: params[:contact_id], 
                                commentable_type: "contact")
    end
    render json: comments
  end
  
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: 422
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end
  
  def comment_params
    params.require(:comment).permit(
      :author_id, 
      :body, 
      :commentable_id, 
      :commentable_type)
  end
end
