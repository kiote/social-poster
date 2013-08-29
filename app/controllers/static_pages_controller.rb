class StaticPagesController < ApplicationController

  def home
  
    return unless current_user
    
    Rails.logger.debug "> StaticPagesController home"
    
    #~ outcome = CreateMessage.run(user: current_user)
    
    # TODO: сначала недосохранённые, потом пересоздаются... чёто не так?
    
    @message = current_user.messages.build
    @message.facebook_message = FacebookMessage.new
    @message.linkedin_message = LinkedinMessage.new
    @message.tumblr_message = TumblrMessage.new
    @message.twitter_message = TwitterMessage.new
    @message.vkontakte_message = VkontakteMessage.new
    
    #~ if outcome.success?
      #~ 
      #~ @message = outcome.result
      #~ 
      #~ facebook_message = CreateFacebookMessage.run(message: @message)
      #~ linkedin_message = CreateLinkedinMessage.run(message: @message)
      #~ tumblr_message = CreateTumblrMessage.run(message: @message)
      #~ twitter_message = CreateTwitterMessage.run(message: @message)
      #~ vkontakte_message = CreateVkontakteMessage.run(message: @message)
    #~ else
      #~ Rails.logger.debug ">"
      #~ Rails.logger.debug "> not created: #{outcome.inspect}"
      #~ flash[:error] = "> not created: #{outcome.inspect}"
    #~ end
    
  end

  def help
  end

  def about
  end

  def contact
  end
end
