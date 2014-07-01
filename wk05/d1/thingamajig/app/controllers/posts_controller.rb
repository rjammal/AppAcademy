class PostsController < ApplicationController
  
  def index
    @posts = current_user.feed_posts.distinct
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.links.new(link_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render 'new'
    end
  end
  
  def destroy
  end
  
  private
  def post_params
    params.require(:post).permit(:body, {circle_ids: []})
  end
  
  def link_params
    params.permit(links: :url)
          .require(:links)
          .values
          .reject { |link| link['url'].empty? }
    
  end
  
end