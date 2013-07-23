class StaticPagesController < ApplicationController

  def home
    
    #~ TODO: right?
    
    #~ @user = current_user
    @message = current_user.messages.build if signed_in?
    #~ @twitter_message = current_user.messages.build type: 'TwitterMessage' if signed_in?
    @twitter_message = TwitterMessage.new
    
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
