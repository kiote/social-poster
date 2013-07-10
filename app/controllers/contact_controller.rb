
class ContactController < ApplicationController
  
  include MessagesSend
  
  layout "social_poster"
  
  before_filter :authenticate_user!
  
  def set_up
  
    @selected_provider = params[:provider]
    
    @authorized_with = Array.new
    current_user.authorisations.each do |auth|
      @authorized_with << auth.provider
    end
    
  end
  
  def new
    
    set_up
    
    unless @authorized_with.include? @selected_provider
      render :text => "please, authorise with #{@selected_provider} first"
    end
    
  end
  
  def create
    
    set_up
    
    auth = current_user.authorisations.find_by_provider(params[:provider])
    
    token = auth.token
    secret = auth.secret
    
    text = params[:send_message][:text]
    
    
    if params[:provider] == 'twitter'
      msg = MessageTwitter.new(text, token, secret)
      msg.send()
    elsif params[:provider] == 'facebook'    
      msg = MessageFacebook.new(text, token, secret)
      msg.send()
    elsif params[:provider] == 'linkedin'
      msg = MessageLinkedin.new(text, token, secret)
      msg.send()
    elsif params[:provider] == 'vkontakte'
      msg = MessageVkontakte.new(text, token, secret)
      msg.send()
    else
      render text: "nowhere to send message"
    end
    
  end
  
end
