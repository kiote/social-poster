
require 'yaml'
require 'twitter_oauth'

KEYS_AND_SECRETS = YAML::load(File.open('keys_and_secrets.yaml'))

class StaticPagesController < ApplicationController
  
  layout "social_poster"
  
  before_filter :set_logger
  
  def set_logger
    @logger = Logger.new("authorisation_log")
    @logger.formatter = proc do |severity, datetime, progname, msg|
      "logger: #{msg}\n"
    end
  end
  
  def test
    @test_value = params[:social_network][:name]
    @keys_and_secrets = KEYS_AND_SECRETS
  end
  
  def authentification
    
    social_network = params[:social_network][:name]
    session[:social_network] = social_network
    
    if social_network == "Facebook"
      auth_facebook
    elsif social_network == "LinkedIN"
      auth_linkedin 
    elsif social_network == "Twitter"
      auth_twitter
    elsif social_network == "VK"
      auth_vk
    else
      @logger.debug "no auth, goto index, session_id %s" % request.session_options[:id]
      redirect_to "/"
    end
    
  end
  
  def auth_facebook
    @logger.debug "auth fb, session_id %s" % request.session_options[:id]
    redirect_to "/"
  end
  
  def auth_linkedin
    @logger.debug "auth lkn, session_id %s" % request.session_options[:id]
    redirect_to "/"
  end
  
  def auth_twitter
    
    social_network = session[:social_network]
    
    @logger.debug "auth twitter, session_id %s" % request.session_options[:id]
    @logger.debug "through %s" % social_network
    
    @auth_through = social_network
    
    client = TwitterOAuth::Client.new(
      :consumer_key => KEYS_AND_SECRETS['twitter']['consumer_key'],
      :consumer_secret => KEYS_AND_SECRETS['twitter']['consumer_secret']
    )
    
    request_token = client.request_token(:oauth_callback => KEYS_AND_SECRETS['twitter']['oauth_callback'])
  #~ client.authentication_request_token
    session[:request_token] = request_token
    redirect_url = request_token.authorize_url
    redirect_to redirect_url
    
    @logger.debug "request_token.token: %s" % session[:request_token].token
    @logger.debug "request_token.secret: %s" % session[:request_token].secret
    @logger.debug "\n"
    
  end
  
  def auth_vk
    @logger.debug "auth vk, session_id %s" % request.session_options[:id]
    redirect_to "/"
  end
  
  def authorisation
    
    social_network = session[:social_network]
    
    if social_network == "Facebook"
      authsn_facebook
    elsif social_network == "LinkedIN"
      authsn_linkedin 
    elsif social_network == "Twitter"
      authsn_twitter
    elsif social_network == "VK"
      authsn_vk
    else
      @logger.debug "no auth, goto index, session_id %s" % request.session_options[:id]
      redirect_to "/"
    end
  end
  
  def authsn_facebook
  end
  
  def authsn_linkedin
  end
  
  def authsn_twitter
    
    @logger.debug "authorisation, session_id %s" % request.session_options[:id]
    
    client = TwitterOAuth::Client.new(
      :consumer_key => KEYS_AND_SECRETS['twitter']['consumer_key'],
      :consumer_secret => KEYS_AND_SECRETS['twitter']['consumer_secret']
    )
    
    request_token = session[:request_token]
    
    @logger.debug "request_token.token: %s" % session[:request_token].token
    @logger.debug "request_token.secret: %s" % session[:request_token].secret
    
    
    access_token = client.authorize(
      request_token.token,
      request_token.secret,
      :oauth_verifier => params[:oauth_verifier]
    )
    
    @logger.debug "access_token.token: %s" % access_token.token
    @logger.debug "access_token.secret: %s" % access_token.secret
    
    @logger.debug "is client authorised: %s" % client.authorized?
    
    response = access_token.request(:get, "https://api.twitter.com/1.1/account/verify_credentials.json ")
    
    msg = JSON.parse(response.body)
    
    @message = msg['screen_name']
    session[:message] = msg['screen_name']
    @social_network = session[:social_network]
    
    redirect_to "/static_pages/post_message"
    
    @logger.debug " %s " % @message
    @logger.debug " %s " % @social_network
    @logger.debug "1"
    @logger.debug "2"
    @logger.debug "3"
  
  end
  
  def authsn_vk
  end
  
  def post_message
    @message = session[:message]
    @social_network = session[:social_network]
  end
  
  
end
