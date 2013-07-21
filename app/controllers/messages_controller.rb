
class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  include SendMessageFunctions
  
  def create
    @message = current_user.messages.build(message_params)
    
    message_sent_statuses = send_message(current_user, @message)
    
    if @message.save
      message_sent_statuses += "; saved"
      flash[:succcess] = message_sent_statuses
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