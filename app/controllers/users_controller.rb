
class CreateUser < Mutations::Command
  
  required do
    string :name
    string :email
    string :password
    string :password_confirmation
  end
  
  def execute
    user = User.create!(inputs)
    user
  end
end

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
      flash[:info] = "> #{outcome.result.name} created"
      
      sign_in user
      redirect_to user
    else
      Rails.logger.debug "> not created %s" % outcome.inspect
      flash[:info] = "> #{user.name} not created"
      render 'new'
    end
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  # TODO: update with mutations
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
end
