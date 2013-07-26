class StaticPagesController < ApplicationController

  def home
    
    if signed_in?
      @message = current_user.messages.build
      
      @message.build_twitter_message
      @message.build_facebook_message
      @message.build_vkontakte_message
      @message.build_linkedin_message
      @message.build_tumblr_message
    end
    
  end

  def help
  end

  def about
  end

  def contact
  end
end
