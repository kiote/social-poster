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
    
    
    #~ not signed in => sign in or sign up
    
    if session[:user_id] == nil
    
      auth = Authorisation.find_by_provider_and_uid(auth_hash[:provider] , auth_hash[:uid])
      
      if auth
        auth.update(auth_hash)
      else
        auth = Authorisation.build_it_with_user(auth_hash)
      end
      
      #~ create the session
      session[:user_id] = auth.user.id
      
      redirect_to "/contact/#{session[:provider]}"
      
    else
      #~ signed in => add the authorization
      
      user = User.find(session[:user_id])
      user.add_authorisation(auth_hash)
      user.update_info(auth_hash)
      
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
