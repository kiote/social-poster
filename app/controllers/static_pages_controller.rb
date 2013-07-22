class StaticPagesController < ApplicationController

  def home
    
    #~ TODO: right?
    
    @user = current_user
    @message = current_user.messages.build if signed_in?
    
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
