class StaticPagesController < ApplicationController

  def home
  
    return unless current_user
    
    Rails.logger.debug "> StaticPagesController home"
    
    @message = current_user.messages.build
    @message.facebook_message = FacebookMessage.new
    @message.linkedin_message = LinkedinMessage.new
    @message.tumblr_message = TumblrMessage.new
    @message.twitter_message = TwitterMessage.new
    @message.vkontakte_message = VkontakteMessage.new
    
  end

  def help
  end

  def about
  end

  def contact
  end
end
