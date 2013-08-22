
class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @messages = @user.messages.paginate(page: params[:page])
  end
  
  def create
    
    outcome = CreateUser.run(params[:user])
    
    user = outcome.result
    
    if outcome.success?
      Rails.logger.debug "> #{outcome.result.name} created"
      flash[:success] = "> #{outcome.result.name} created"
      
      sign_in user
      redirect_to user
    else
      Rails.logger.debug "> not created %s" % outcome.inspect
      flash[:error] = "> not created %s" % outcome.inspect
      @user = User.new
      render 'new'
    end
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
  
    outcome = UpdateUser.run(params[:user], user: User.find(params[:id]))
    
    user = outcome.result
    
    if outcome.success?
      Rails.logger.debug "> #{outcome.result.name} updated"
      flash[:success] = "> #{outcome.result.name} updated"
      
      sign_in user
      redirect_to user
    else
      Rails.logger.debug "> not updated %s" % outcome.inspect
      flash[:error] = "> not updated %s" % outcome.inspect
      @user = User.find(params[:id])
      render 'edit'
    end
    
  end
  
end
