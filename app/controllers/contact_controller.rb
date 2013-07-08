

class Message
  attr_reader :body
  
  def initialize
    @body = "ve"
  end
end

class ContactController < ApplicationController
  
  layout "social_poster"
  
  before_filter :set_up, :except => [:update, :destroy]
  
  def set_up
  
    @user = User.find(session[:user_id])
    @selected_provider = params[:provider]
    
    @authorized_with = Array.new
    @user.authorisations.each do |auth|
      @authorized_with << auth.provider
    end
    
  end
  
  def new
    @message = Message.new    
    
    unless @authorized_with.include? @selected_provider
      render :text => "please, authorise with #{@selected_provider} first"
    end
    
  end
  
  def create
    
    #~ for twitter
    consumer = OAuth::Consumer.new("78Xe54R18Dx0xjehhGOAw", "IMNaQoy65nLkWa15qp5HvoqHYAu5XTXCfgg86fKC0", { :site => "http://api.twitter.com" })
    # now create the access token object from passed values
    
    auth = @user.authorisations.find_by_provider(params[:provider])
    
    oauth_token_token = auth.token
    oauth_token_secret = auth.secret
    
    token_hash = { :oauth_token => oauth_token_token, :oauth_token_secret => oauth_token_secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
    
    text = "%s %s" % [params[:message], Time.new]
    response = access_token.request(:post, "http://api.twitter.com/1.1/statuses/update.json", :status => text)
    #~ response = access_token.request(:get, "http://api.twitter.com/1.1/statuses/user_timeline.json")
    
    render :text => "%s" % response.body
    
  end
  
end
