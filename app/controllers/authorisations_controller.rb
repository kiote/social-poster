class AuthorisationsController < ApplicationController
  
  include AuthorisationsExtra
  
  def new
  end
  
  #~ TODO:
  
  def create
    auth_hash = read_authhash(request.env['omniauth.auth'])
    if session[:user_id] == nil
      auth = Authorisation.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])
      if auth
        auth.update(auth_hash)
      else
        auth = Authorisation.build_it_with_user(auth_hash, current_user)
      end
      session[:user_id] = auth.user.id
      redirect_to root_path
    else
      user = User.find(session[:user_id])
      user.add_authorisation(auth_hash)
      user.update_info(auth_hash)
      redirect_to root_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def failure
  end
  
end
