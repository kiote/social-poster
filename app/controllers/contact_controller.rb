

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
    @message = "ksajbvksadbkdjbckdjsajbc %s" % Time.new
    
    unless @authorized_with.include? @selected_provider
      render :text => "please, authorise with #{@selected_provider} first"
    end
    
  end
  
  def create
    
    #~ TODO: remove ugly cases
    if params[:provider] == 'twitter'
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
      
    elsif params[:provider] == 'facebook'
      auth = @user.authorisations.find_by_provider(params[:provider])      
      oauth_token_token = auth.token
      oauth_token_secret = auth.secret
      
      fb_user ||= FbGraph::User.me(auth.token)
      text = "%s %s" % [params[:message], Time.new]
      fb_user.feed!(:message => text, :name => 'feed_name')
      
    elsif params[:provider] == 'linkedin'
    
      auth = @user.authorisations.find_by_provider(params[:provider])      
      oauth_token_token = auth.token
      oauth_token_secret = auth.secret
      
      consumer_options = {
        :request_token_path => "/uas/oauth/requestToken?scope=r_basicprofile+rw_nus",
        :access_token_path  => "/uas/oauth/accessToken",
        :authorize_path     => "/uas/oauth/authorize",
        :api_host           => "https://api.linkedin.com",
        :auth_host          => "https://www.linkedin.com"
      }
      
      client = LinkedIn::Client.new('l6on5uqdtfc8', 'LiDHc2gdkyYTOEuB', consumer_options)
 
      client.authorize_from_access(oauth_token_token, oauth_token_secret)
      
      Rails.logger.debug "---==="
      Rails.logger.debug "%s" % client.profile
      Rails.logger.debug "---==="
      
      text = "%s %s" % [params[:message], Time.new]
      #~ client.add_share(:comment => text)
      
    elsif params[:provider] == 'vkontakte'
      
      auth = @user.authorisations.find_by_provider(params[:provider])      
      oauth_token_token = auth.token
      oauth_token_secret = auth.secret
      
      vk = VkontakteApi::Client.new auth.token
      
      Rails.logger.debug "---===+++++++"
      text = "%s %s" % [params[:message], Time.new]
      #~ vk.wall.post text
      Rails.logger.debug "%s" % auth.token
      Rails.logger.debug "---===++++++++"
      
    else
      render :text => "nothing"
    end
    
  end
  
end
