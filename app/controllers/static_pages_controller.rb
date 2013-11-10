
class StaticPagesController < ApplicationController

  def home
  
    return if not current_user
    
    @message = current_user.messages.build
    @message.facebook_message = FacebookMessage.new
    @message.linkedin_message = LinkedinMessage.new
    @message.tumblr_message = TumblrMessage.new
    @message.twitter_message = TwitterMessage.new
    @message.vkontakte_message = VkontakteMessage.new
    
    @message.facebook_message.text = ''
    @message.linkedin_message.text = ''
    @message.tumblr_message.text = ''
    @message.twitter_message.text = ''
    @message.vkontakte_message.text = ''

  end

  def help
  end

  def about
  end

  def contact
  end
end
