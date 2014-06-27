class CatsController < ApplicationController
  
  before_action :show_cat, only: [:edit, :update]
  
  def index
    @cats = Cat.all
    render 'index'
  end
  
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render 'new'
    end

  end
  
  def new
    @cat = Cat.new
    
    render 'new'
  end
  
  def show
    @cat = Cat.find(params[:id])
    render 'show'
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render 'edit'
  end
  
  def update
    @cat = Cat.find(params[:id])
    
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render 'edit'
    end
  end
  
  private
  
  def show_cat
    @cat = Cat.find(params[:id])
    if @cat.user_id != current_user.id
      flash[:errors] = "Can't edit a cat you dont own"
      redirect_to cat_url(@cat)
    end
  end

  def cat_params
    params.require(:cat).permit(:name, :age, :color, :birth_date, :sex)
  end
end