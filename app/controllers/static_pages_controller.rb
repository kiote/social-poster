class StaticPagesController < ApplicationController

  def home
    
    if current_user
      # что такое вообще этот Time.new? может тут Time.now подразумевалось?
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
