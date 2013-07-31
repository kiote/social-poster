class StaticPagesController < ApplicationController

  def home
    
    if current_user
      @message = current_user.messages.build sent_at: Time.new
      
      #~ TODO:
      #~ - это тоже не должно быть в контроллере
      
      @message.build_facebook_message
      @message.build_linkedin_message
      @message.build_tumblr_message
      @message.build_twitter_message
      @message.build_vkontakte_message
      
    end
    
  end

  def help
  end

  def about
  end

  def contact
  end
end
