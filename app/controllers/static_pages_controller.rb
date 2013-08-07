class StaticPagesController < ApplicationController

  def home
    return unless current_user
    
    @message = current_user.messages.build
    @message.build_empty_texts
  end

  def help
  end

  def about
  end

  def contact
  end
end
