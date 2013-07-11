class SessionsController < ApplicationController
  
  include SessionsControllerExtra
  
  layout "social_poster"
  
  def new
  end
  
  def create
  
    Rails.logger.debug "> %s" % 'touch'
    
    auth_hash = read_authhash(request.env['omniauth.auth'])
    
    Rails.logger.debug ""
    Rails.logger.debug " ---===+++ request.env['omniauth.auth']: "
    Rails.logger.debug ""
    Rails.logger.debug request.env['omniauth.auth'].to_yaml
    
    #~ TODO: правильно учитывается поставщик, под которым выполнен вход?
    session[:provider] = auth_hash[:provider]
    
    unless session[:user_id]
    
      #~ not signed in => sign in or sign up
      auth = Authorisation.find_or_create(auth_hash)
      
      #~ create the session
      session[:user_id] = auth.user.id
      
      redirect_to "/contact/#{session[:provider]}"
      
    else
      
      #~ signed in => add the authorization
      User.find(session[:user_id]).add_provider(auth_hash)
      
      redirect_to "/contact/#{session[:provider]}"
      
    end
    
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def failure
    #~ render :text => "Sorry, but you didn't allow access to our app!"
  end
  
end
