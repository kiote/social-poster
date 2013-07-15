class SessionsController < ApplicationController
  
  include SessionsControllerExtra
  
  #~ layout "social_poster"
  
  def new
  end
  
  def create
    
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:email])
      #~ запустить пользователя и показать евойную страницу
    else
      #~ сообщить об ошибке и вернуть ко входу
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def failure
  end
  
end
