
class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  include SendMessageFunctions
  
  def create
    
    Rails.logger.debug "> %s" % params.to_yaml
  
    #~ message_sent_statuses = send_message(current_user, @message)
    
    @message = current_user.messages.build
    
    @message.build_twitter_message text: params[:message][:twitter_text]
    @message.build_facebook_message text: params[:message][:facebook_text]
    @message.build_vkontakte_message text: params[:message][:vkontakte_text]
    @message.build_linkedin_message text: params[:message][:linkedin_text]
    @message.build_tumblr_message text: params[:message][:tumblr_text]
    
    if @message.save
      flash[:succcess] = "message saved %s %s" #% [@message.text.length, @message.type]
      redirect_to root_url
    else
      #~ render 'static_pages/home'
      flash[:succcess] = "message not saved %s %s"
      redirect_to root_url
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
