

class Message
  attr_reader :body
end

class ContactController < ApplicationController
  
  def new
    @message = Message.new
  end
  
  def create
    
    #~ for twitter
    consumer = OAuth::Consumer.new("78Xe54R18Dx0xjehhGOAw", "IMNaQoy65nLkWa15qp5HvoqHYAu5XTXCfgg86fKC0", { :site => "http://api.twitter.com" })
    # now create the access token object from passed values
    
    oauth_token_token = session[:token]
    oauth_token_secret = session[:secret]
    
    token_hash = { :oauth_token => oauth_token_token, :oauth_token_secret => oauth_token_secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
    
    text = "want to post current time: %s" % Time.new
    response = access_token.request(:post, "http://api.twitter.com/1.1/statuses/update.json", :status => text)
    #~ response = access_token.request(:get, "http://api.twitter.com/1.1/statuses/user_timeline.json")
    
    render :text => "%s" % response.body
    
  end
  
end
