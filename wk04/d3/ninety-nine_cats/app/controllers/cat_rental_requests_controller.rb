class CatRentalRequestsController < ApplicationController
  
  
  def new
    
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
    
    render 'new'
  end
  
  def create
    
    @cat_rental_request = CatRentalRequest.new(rental_params)
    
    if @cat_rental_request.save 
      redirect_to cat_url(rental_params[:cat_id])
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render 'new'
    end
    
  end
  
  private
  
  def rental_params
    params.require(:cat_rental_request)
          .permit(:cat_id, :start_date, :end_date, :status)
  end
  
end