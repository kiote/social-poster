class StaticPagesController < ApplicationController

  def home
    
    if current_user
      @message = current_user.messages.build sent_at: Time.new
      
      @message.build_empty_texts
      
    end
    
  end

  def help
  end

  def about
  end

  def contact
  end
end
