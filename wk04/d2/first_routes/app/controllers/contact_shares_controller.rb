class ContactSharesController < ApplicationController
  def create
    contact_share = ContactShare.new(contact_shares_params)
    if contact_share.save
      render json: contact_share
    else
      render json: contact_share.errors.full_messages, status: 422
    end
  end
  
  def destroy
    contact_share = ContactShare.find(params[:id])
    contact_share.destroy
    render json: contact_share
  end
  
  def contact_shares_params
    params.require(:contact_share).permit(:contact_id, :user_id)
  end
end
