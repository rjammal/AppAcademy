class SecretsController < ApplicationController

  def create
    sleep(2)
    recipient = User.find(secret_params[:recipient_id])
    @secret = current_user.authored_secrets.new(secret_params)
    if @secret.save
      render json: @secret
    else
      flash.now[:errors] = @secret.errors.full_messages
      render json: @secret.errors.full_messages, status: 422
    end
  end
  
  def new
  end

  private

  def secret_params
    params.require(:secret).permit(:title, :recipient_id)
  end
end

