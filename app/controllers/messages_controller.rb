
class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    
    Rails.logger.debug "> create messages controllere"
    Rails.logger.debug "> %s" % params.to_s
  
    @message = current_user.messages.build
    @message.build_texts(params)
    
    # TODO: like in messafe.rb
    ms_fb = MessageSendersExtra::MessageSenderFacebook.new(current_user)
    ms_ln = MessageSendersExtra::MessageSenderLinkedin.new(current_user)
    ms_tu = MessageSendersExtra::MessageSenderTumblr.new(current_user)
    ms_tw = MessageSendersExtra::MessageSenderTwitter.new(current_user)
    ms_vk = MessageSendersExtra::MessageSenderVkontakte.new(current_user)
    
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
