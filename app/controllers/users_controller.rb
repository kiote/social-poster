class UsersController < ApplicationController
  
  layout "social_poster"
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.create(user_params)
  end
  
  private
    def user_params
    #~ TODO
    #~ User.new(name: 'Savva', email: 'vcabba@rambler.ru', password: 'qqqwww', password_confirmation: 'qqqwww')
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
