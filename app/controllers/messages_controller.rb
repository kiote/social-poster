
class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    
    outcome = CreateMessage.run(params, user: current_user)
    
    if outcome.success?
      
      Rails.logger.debug "> created: #{outcome.inspect}"
      flash[:info] = "> created: #{outcome.inspect}"
    else
      Rails.logger.debug ">"
      Rails.logger.debug "> not created: #{outcome.inspect}"
      flash[:error] = "> not created: #{outcome.inspect}"
    end
    
    Rails.logger.debug "> create messages controllere"
    Rails.logger.debug "> %s" % params.to_s
    
    if outcome.success?
    
      @message = outcome.result
      
      # TODO: doub
      
      params[:facebook_message][:text] = params[:facebook_message][:text].sub("<br>", "")
      params[:linkedin_message][:text] = params[:linkedin_message][:text].sub("<br>", "")
      params[:twitter_message][:text] = params[:twitter_message][:text].sub("<br>", "")
      
      facebook_message = CreateFacebookMessage.run(params[:facebook_message], message: @message)
      linkedin_message = CreateLinkedinMessage.run(params[:linkedin_message], message: @message)
      tumblr_message = CreateTumblrMessage.run(params[:tumblr_message], message: @message)
      twitter_message = CreateTwitterMessage.run(params[:twitter_message], message: @message)
      vkontakte_message = CreateVkontakteMessage.run(params[:vkontakte_message], message: @message)
      
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
      
      flash[:success] = "%s; sent with statuses: %s" % [flash[:success], sent_statuses]
      
      Rails.logger.debug "> sent statuses: %s" % sent_statuses
      
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
