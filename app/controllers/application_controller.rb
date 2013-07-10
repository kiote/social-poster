class ApplicationController < ActionController::Base
  
  
  protect_from_forgery
  
  helper_method :current_user
  helper_method :user_signed_in?

  private
    def current_user
      if session[:user_id]
        @current_user ||= User.find_by_id(session[:user_id])
      end
    end
    
    def user_signed_in?
      return true if current_user 
    end
      
    def authenticate_user!
      if !current_user
        flash[:error] = 'You need to sign in before accessing this page!'
        redirect_to '/signin'
      end
    end
  
end
