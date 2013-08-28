class StaticPagesController < ApplicationController

  def home
    return unless current_user
    
    #TODO: correct message creation
    
    outcome = CreateMessage.run(user: current_user)
    
    if outcome.success?
      
      @message = outcome.result
      
      facebook_message = CreateFacebookMessage.run(message: @message)
      linkedin_message = CreateLinkedinMessage.run(message: @message)
      tumblr_message = CreateTumblrMessage.run(message: @message)
      twitter_message = CreateTwitterMessage.run(message: @message)
      vkontakte_message = CreateVkontakteMessage.run(message: @message)
    else
      Rails.logger.debug ">"
      Rails.logger.debug "> not created: #{outcome.inspect}"
      flash[:error] = "> not created: #{outcome.inspect}"
    end
    
  end

  def help
  end

  def about
  end

  def contact
  end
end
