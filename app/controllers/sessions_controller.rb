class SessionsController < ApplicationController
  
  include SessionsControllerExtra
  
  before_filter :set_logger  
  
  def set_logger
    @logger = Logger.new("sessions.log")
    @logger.formatter = proc do |severity, datetime, progname, msg|
      "> #{msg}\n"
    end
  end
  
  def new
  end

  def create
    
    
    auth_hash = read_authhash(request.env['omniauth.auth'])
    
    @logger.debug("%s" % auth_hash.to_xml)
    
    if session[:user_id]
      # Means our user is signed in. Add the authorization to the user
      User.find(session[:user_id]).add_provider(auth_hash)
      
      render :text => "You can now login using #{auth_hash[:provider].capitalize} too!"
    else
      # Log him in or sign him up
      auth = Authorisation.find_or_create(auth_hash)
      
      # Create the session
      session[:user_id] = auth.user.id
      
      render :text => "Welcome #{auth.user.name}!"
    end
    
  end
  
  def destroy
    session[:user_id] = nil
    render :text => "You've logged out!"
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end
  
end
