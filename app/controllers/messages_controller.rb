
class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  include SendMessageFunctions
  
  def create
    
    Rails.logger.debug "> %s" % params.to_yaml
  
    @message = current_user.messages.build
    @message.build_texts(params)
    
    ms_fb = MessageSenderFacebook.new(current_user)
    ms_ln = MessageSenderLinkedin.new(current_user)
    ms_tu = MessageSenderTumblr.new(current_user)
    ms_tw = MessageSenderTwitter.new(current_user)
    ms_vk = MessageSenderVkontakte.new(current_user)
    
    sent_statuses = Array.new
    
    sent_statuses << ms_fb.send_message(@message)
    sent_statuses << ms_ln.send_message(@message)
    sent_statuses << ms_tu.send_message(@message)
    sent_statuses << ms_tw.send_message(@message)
    sent_statuses << ms_vk.send_message(@message)
    
    sent_statuses = sent_statuses.join('; ')
    
    Rails.logger.debug "> sent statuses: %s" % sent_statuses
    
    if @message.save
      flash[:success] = "message saved and sent with statuses: %s" % sent_statuses
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
