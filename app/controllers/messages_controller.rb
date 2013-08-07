
class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  include SendMessageFunctions
  
  def create
    
    Rails.logger.debug "> %s" % params.to_yaml
  
    @message = current_user.messages.build sent_at: Time.new
    @message.build_texts(params)
    
    message_sender = MessageSender.new(current_user)
    message_sender.send_message(@message)
    
    #~ sent_statuses = send_message(@message, current_user)
    
    if @message.save
      flash[:succcess] = "message saved and sent with statuses: %s" % sent_statuses
    else
      flash[:fail] = "message not saved"
    end
  
    redirect_to root_url
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
