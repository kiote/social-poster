class StaticPagesController < ApplicationController

  def home
    @message = current_user.messages.build sent_at: Time.new
    
    @message.build_facebook_message
    @message.build_linkedin_message
    @message.build_tumblr_message
    @message.build_twitter_message
    @message.build_vkontakte_message
    
  end

  def help
  end

  def about
  end

  def contact
  end
end
