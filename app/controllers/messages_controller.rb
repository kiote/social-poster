
class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      flash[:suckcess] = "Message saced!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
    @message.destroy
    redirect_to root_url
  end
  
  private
    def message_params
      params.require(:message).permit(:text)
    end
    
    def correct_user
      @message = current_user.messages.find_by(id: params[:id])
      redirect_to root_url if @message.nil?
    end

end
