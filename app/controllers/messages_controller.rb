
class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  include SendMessageFunctions
  
  def create
    
    Rails.logger.debug "> %s" % params.to_yaml
  
    @message = current_user.messages.build sent_at: Time.new
    
    #~ TODO: test if twitter message length more than 140 chars
    
    @message.build_facebook_message text: params[:facebook_message][:text] if params[:facebook_message][:text].length > 0
    @message.build_linkedin_message text: params[:linkedin_message][:text] if params[:linkedin_message][:text].length > 0
    @message.build_tumblr_message text: params[:tumblr_message][:text] if params[:tumblr_message][:text].length > 0
    @message.build_twitter_message text: params[:twitter_message][:text] if params[:twitter_message][:text].length > 0
    @message.build_vkontakte_message text: params[:vkontakte_message][:text] if params[:vkontakte_message][:text].length > 0
    
    #~ @message.facebook_message.build text: params[:facebook_text] if params[:facebook_text].length > 0
    #~ @message.linkedin_message.build text: params[:linkedin_text] if params[:linkedin_text].length > 0
    #~ @message.tumblr_message.build text: params[:tumblr_text] if params[:tumblr_text].length > 0
    #~ @message.twitter_message.build text: params[:twitter_text] if params[:twitter_text].length > 0
    #~ @message.vkontakte_message.build text: params[:vkontakte_text] if params[:vkontakte_text].length > 0
    
    sent_statuses = send_message(@message, current_user)
    
    if @message.save
      flash[:succcess] = "message saved and sent with statuses: %s" % sent_statuses
      redirect_to root_url
    else
      flash[:fail] = "message not saved"
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
