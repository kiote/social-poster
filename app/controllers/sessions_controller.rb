class SessionsController < ApplicationController
  
  include SessionsControllerExtra
  
  def new
  end
  
  def create
    
    auth_hash = read_authhash(request.env['omniauth.auth'])
    
    Rails.logger.debug ""
    Rails.logger.debug " ---===+++ request.env['omniauth.auth']: "
    Rails.logger.debug ""
    Rails.logger.debug request.env['omniauth.auth'].to_yaml
    

    request.env['omniauth.auth']['credentials']['token'] ? session[:token] = request.env['omniauth.auth']['credentials']['token'] : session[:token] = ''
    request.env['omniauth.auth']['credentials']['secret'] ? session[:secret] = request.env['omniauth.auth']['credentials']['secret'] : session[:secret] = ''
    
    
    unless session[:user_id]
    
      #~ not signed in => sign in or sign up
      auth = Authorisation.find_or_create(auth_hash)
      
      #~ create the session
      session[:user_id] = auth.user.id
      
      render :text => "Welcome #{auth.user.name}!"
      
    else
      
      #~ signed in => add the authorization
      User.find(session[:user_id]).add_provider(auth_hash)
      
      render :text => "You can now login using #{auth_hash[:provider].capitalize} too!"
      
    end
    
  end
  
  def destroy
    session[:user_id] = nil
    #~ render :text => "You've logged out!"
  end

  def failure
    #~ render :text => "Sorry, but you didn't allow access to our app!"
  end
  
end
