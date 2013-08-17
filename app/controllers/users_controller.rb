
class CreateUser < Mutations::Command
  
  required do
    string :name
    string :email
    string :password
    string :password_confirmation
  end
  
  def execute
    
    if password != password_confirmation
      add_error(:password_confirmation, :doesnt_match, "Your passwords don't match.")
      return
    end
    
    if User.find_by_email(email)
      add_error(:email, :doesnt_unique, "Your email already taken.")
      return
    end
    
    user = User.create!(inputs)
    user
  end
end

class UpdateUser < Mutations::Command
  
  required do
    model :user
    integer :id
  end
  
  optional do
    string :name
    string :email
    # TODO: но если обновил пароль, то и будь добр обнови подтверждение
    string :password
    string :password_confirmation
  end
  
  def execute
    # TODO: так почемуто unknown attribute user
    #~ user.update_attributes!(inputs)
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
  
  # TODO: update with mutations
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
      flash[:error] = "> #{user.name} not updated"
      render 'edit'
    end
    
  end
  
end
