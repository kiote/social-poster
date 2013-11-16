
class UsersController < ApplicationController
  
  before_action :signed_in_user, only: [:index, :edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @messages = @user.messages.paginate(page: params[:page])
  end
  
  def index
    @users = User.all
  end
  
  def create
    
    outcome = UserCreate.run(params[:user])
    
    user = outcome.result
    
    if outcome.success?
      flash[:success] = "> #{outcome.result.name} created"
      
      sign_in user
      redirect_to user
    else
      flash[:error] = "> not created %s" % outcome.inspect
      @user = User.new
      render 'new'
    end
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
  
    outcome = UserUpdate.run(params[:user], user: User.find(params[:id]))
    
    user = outcome.result
    
    if outcome.success?
      flash[:success] = "> #{outcome.result.name} updated"
      
      sign_in user
      redirect_to user
    else
      flash[:error] = "> not updated %s" % outcome.inspect
      @user = User.find(params[:id])
      render 'edit'
    end
    
  end
  
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
    
end
