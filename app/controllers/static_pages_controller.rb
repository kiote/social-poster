
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
  
    @logger.debug "authentification, session_id %s" % request.session_options[:id]
    @logger.debug "through %s" % params[:social_network][:name]
    
    @auth_through = params[:social_network][:name]
    
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
  
  def authorisation
    
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
    logger.debug "msg: %s" % msg
    
    @message = msg['screen_name']
    
    @logger.debug "\n"
    @logger.debug "\n"
    @logger.debug "\n"
  
  end
  
  
end
