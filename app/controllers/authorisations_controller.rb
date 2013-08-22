
class CreateAuthorisation < Mutations::Command
  
  required do
    model :user
    string :provider
    string :uid
    string :token
    string :secret
  end
  
  def execute
    auth = Authorisation.create!(inputs)
    auth
  end
  
end

class AuthorisationsController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  include AuthorisationsExtra
  
  def create
    
    auth_hash = read_authhash(request.env['omniauth.auth'])
    
    params[:provider] = auth_hash[:provider]
    params[:uid] = auth_hash[:uid]
    params[:token] = auth_hash[:token]
    params[:secret] = auth_hash[:secret]
    params[:secret] = "secret" if auth_hash[:secret].length < 1
    
    
    outcome = CreateAuthorisation.run(params, user: current_user)
    
    Rails.logger.debug "> params: %s" % params
    
    if outcome.success?
      Rails.logger.debug "> #{outcome.result.provider} connected"
      flash[:info] = "> #{outcome.result.provider} connected"
    else
      Rails.logger.debug "> #{outcome.inspect} not connected"
      flash[:error] = "> #{outcome.inspect} not connected"
    end
    
    redirect_to root_url
  end
  
  def destroy
    @authorisation.destroy
    redirect_to root_url
  end

  def failure
  end
  
  private
    
    def correct_user
      @authorisation = current_user.authorisations.find_by(id: params[:id])
      redirect_to root_url if @authorisation.nil?
    end
  
end
