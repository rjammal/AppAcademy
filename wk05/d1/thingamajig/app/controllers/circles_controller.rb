class CirclesController < ApplicationController

  def index
    @circles = Circle.where(owner: current_user)
  end
  
  def show
    @circle = Circle.find(params[:id])
  end
  
  def create
    @circle = Circle.new(circle_params)
    @circle.owner_id = current_user.id
    if @circle.save
      redirect_to circle_url(@circle)
    else
      flash.now[:errors] = @circle.errors.full_messages
      render 'new'
    end
  end
  
  def new
    @circle = Circle.new
  end
  
  def edit
    @circle = Circle.find(params[:id])
  end
  
  def update
    @circle = Circle.find(params[:id])
    if @circle.update_attributes(circle_params)
      redirect_to circle_url(@circle)
    else
      flash.now[:errors] = @circle.errors.full_messages
      render 'edit'
    end
  end
  
  def destroy
    Circle.find(params[:id]).destroy
    redirect_to circles_url
  end

  def circle_params
    params.require(:circle).permit(:name, {member_ids: []})
  end
  
end