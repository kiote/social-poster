class SessionsController < ApplicationController
  
  include SessionsControllerExtra
  
  def new
  end

  def create
    
    auth_hash = read_authhash(request.env['omniauth.auth'])
    
    Rails.logger.debug auth_hash.to_yaml
    
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
      #~ redirect_to :controller => 'send_message', :action => 'new', :provider => auth_hash[:provider]
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
