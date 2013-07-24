class StaticPagesController < ApplicationController

  def home
    
    #~ TODO: right?
    
    #~ @user = current_user
    @message = current_user.messages.build if signed_in?
    @twitter_message = current_user.messages.build type: 'TwitterMessage' if signed_in?
    @facebook_message = current_user.messages.build type: 'FacebookMessage' if signed_in?
    @linkedin_message = current_user.messages.build type: 'LinkedinMessage' if signed_in?
    @vkontakte_message = current_user.messages.build type: 'VkontakteMessage' if signed_in?
    @tumblr_message = current_user.messages.build type: 'TumblrMessage' if signed_in?
    #~ @twitter_message = TwitterMessage.new
    
    Rails.logger.debug "> %s" % @twitter_message
    if signed_in?
      @twitter_message = TwitterMessage.new
    end
    
  end

  def help
  end

  def about
  end

  def contact
  end
end
