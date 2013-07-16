class UsersController < ApplicationController
  
  #~ layout "social_poster"
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @messages = @user.messages.paginate(page: params[:page])
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
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #~ TODO: this; settings' link also
    else
      render 'edit'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
