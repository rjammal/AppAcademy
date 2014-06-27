class CatRentalRequestsController < ApplicationController
  
  before_action :owner_approval, only: [:approve, :deny]
  
  def new
    
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
    
    render 'new'
  end
  
  def create
    
    @cat_rental_request = CatRentalRequest.new(rental_params)
    @cat_rental_request.user_id = current_user.id
    if @cat_rental_request.save 
      redirect_to cat_url(@cat_rental_request[:cat_id])
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render 'new'
    end
    
  end
  
  def approve
    request = CatRentalRequest.find(params[:cat_rental_request_id])
    request.approve!
    redirect_to cat_url(request[:cat_id])
  end
  
  def deny
    request = CatRentalRequest.find(params[:cat_rental_request_id])
    request.deny!
    redirect_to cat_url(request[:cat_id])
  end
  
  private
  
  def rental_params
    params.require(:cat_rental_request)
          .permit(:cat_id, :start_date, :end_date, :status)
  end
  
  def owner_approval
    cat_rental = CatRentalRequest.find(params[:cat_rental_request_id])
    cat = Cat.find(cat_rental.cat_id)
    owner = cat.user_id
    if owner != current_user.id
      flash[:errors] = "Can't approve or deny requests for a cat you dont own"
      redirect_to cat_url(cat)
    end
  end
  
end