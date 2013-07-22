
class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  include SendMessageFunctions
  
  def create
    
    @message = current_user.messages.build(message_params)
    @twitter_message = current_user.messages.build(twitter_message_params)
    @facebook_message = current_user.messages.build(facebook_message_params)
    
    #~ message_sent_statuses = send_message(current_user, @message)
    
    if @message.save
      #~ message_sent_statuses += "; saved"
      flash[:succcess] = 'message saved'#message_sent_statuses
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
    
    #~ TODO: похоже придётся STI делать
    def message_params
      params.require(:message).permit(:text, :type)
    end
    
    def correct_user
      @message = current_user.messages.find_by(id: params[:id])
      redirect_to root_url if @message.nil?
    end

end
