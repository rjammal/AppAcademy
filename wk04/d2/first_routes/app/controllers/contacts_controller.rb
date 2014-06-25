class ContactsController < ApplicationController
  
  def create
    contact = Contact.new(contact_params)
        
    if contact.save
      render json: contact
    else
      render json: contact.errors.full_messages, status: 422
    end
  end
  
  def show
    render json: Contact.find(params[:id])
  end
  
  def index
    render json: Contact.contacts_for_user_id(params[:user_id])
  end
  
  def update
    contact = Contact.find(params[:id])
    
    if contact.update_attributes(contact_params)
      render json: contact
    else
      render json: contact.errors.full_messages, status: 422
    end
  end
  
  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    render json: contact
  end
  
  def favorite
    contact = Contact.find(params[:id])
    if contact.user_id == Integer(params[:user_id])
      contact.favorite = true
      contact.save
      render json: contact
    else
      contact_share = ContactShare.find_by_user_id_and_contact_id(
                            params[:user_id], params[:id])
      contact_share.favorite = true
      contact_share.save
      render json: contact_share
    end
  end
  
  private 
  
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
