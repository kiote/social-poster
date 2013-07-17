class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #~ запустить пользователя и показать евойную страницу
      sign_in user
      redirect_to user
    else
      #~ сообщить об ошибке и вернуть ко входу
      flash.now[:error] = 'сообщаю, что ошибка'
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

  def failure
  end
  
end
