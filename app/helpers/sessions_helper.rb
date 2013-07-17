module SessionsHelper
  
  def sign_in user
    remember_me = User.new_remember_token
    cookies.permanent[:remember_me] = remember_me
    user.update_attribute(:remember_me, User.encrypt(remember_me))
    
    #~ TODO: its for auth attach
    session[:user_id] = user.id
    
    self.current_user = user
  end
  
  def sign_out
    self.current_user = nil
    
    #~ TODO: its for auth attach
    session[:user_id] = nil
    
    cookies.delete(:remember_me)
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    remember_me = User.encrypt(cookies[:remember_me])
    @current_user ||= User.find_by(remember_me: remember_me)
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "please, sign in"
    end
  end
  
  def store_location
    session[:return_to] = request.url
  end
  
  
  
end
