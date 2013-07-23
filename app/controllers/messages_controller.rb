
class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  include SendMessageFunctions
  
  def create
    
    Rails.logger.debug "> %s" % params.to_yaml
    #~ TODO: также полагается что сообщение отправляется только в ту сеть, вкладка которой выбрана
    
    #~ @message = current_user.messages.build(message_params)
    #~ @message.type = params[:type]
    
    if params[:type] == 'TwitterMessage'
      #~ @message = TwitterMessage.new
      #~ @message.text = params[:text]
      #~ @message.user = current_user
      @message = current_user.messages.build type: 'TwitterMessage', text: params[:twitter_message][:text]
      Rails.logger.debug "> TwitterMessage %s" % @message
      Rails.logger.debug "> TwitterMessage %s" % @message.text
      Rails.logger.debug "> TwitterMessage %s" % @message.type
      Rails.logger.debug "> TwitterMessage %s" % params[:text]
    else
      @message = current_user.messages.build(message_params)
    end
    
    #~ message_sent_statuses = send_message(current_user, @message)
    
    if @message.save
      flash[:succcess] = "message saved %s %s" % [@message.text.length, @message.type]
      redirect_to root_url
    else
      #~ render 'static_pages/home'
      flash[:succcess] = "message not saved %s %s" % [@message.text.length, @message.type]
      redirect_to root_url
    end
  end
  
  def destroy
    @message.destroy
    redirect_to root_url
  end
  
  private
    
    #~ TODO: type?
    def message_params
      if params[:type] == "TwitterMessage"
        params.require(:twitter_message).permit(:text, :type)
      elsif params[:type] == "FacebookMessage"
        params.require(:facebook_message).permit(:text, :type)
      else
        params.require(:message).permit(:text)
      end
    end
    
    #~ def twitter_message_params
      #~ params.require(:twitter_message).permit(:text, :type)
    #~ end
    #~ 
    #~ def facebook_message_params
      #~ params.require(:facebook_message).permit(:text, :type)
    #~ end
    #~ 
    #~ def linkedin_message_params
      #~ params.require(:linkedin_message).permit(:text, :type)
    #~ end
    #~ 
    #~ def tumblr_message_params
      #~ params.require(:tumblr_message).permit(:text, :type)
    #~ end
    #~ 
    #~ def vkontakte_message_params
      #~ params.require(:vkontakte_message).permit(:text, :type)
    #~ end
    
    
    def correct_user
      @message = current_user.messages.find_by(id: params[:id])
      redirect_to root_url if @message.nil?
    end

end
