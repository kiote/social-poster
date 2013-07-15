class UsersController < ApplicationController
  
  #~ layout "social_poster"
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:msg] = "ё"
      redirect_to @user
    else
      render 'new'
    end
    
  end
  
  private
    def user_params
    #~ TODO:
    #~ User.new(name: 'Savva', email: 'vcabba@rambler.ru', password: 'qqqwww', password_confirmation: 'qqqwww')
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
