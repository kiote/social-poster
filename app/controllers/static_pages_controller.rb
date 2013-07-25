class StaticPagesController < ApplicationController

  def home
    
    @message = current_user.messages.build if signed_in?
    
  end

  def help
  end

  def about
  end

  def contact
  end
end
