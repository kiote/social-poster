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
    
    Rails.logger.debug "+++++++++++++++++"
    Rails.logger.debug params.to_yaml
    Rails.logger.debug "-----------------"
    Rails.logger.debug request.env['omniauth.auth'].to_yaml
    Rails.logger.debug "-----------------"
    Rails.logger.debug auth_hash.to_yaml
    Rails.logger.debug "+++++++++++++++++"
    
    @auth = current_user.authorisations.build(
      provider: auth_hash[:provider],
      uid: auth_hash[:uid],
      token: auth_hash[:token],
      secret: auth_hash[:secret]
    )
    
    if @auth.save
      Rails.logger.debug "> auth.save"
      flash[:info] = "auth connected"
    else
      Rails.logger.debug "> auth didnt.save"
      flash[:info] = "auth didnt.saved"
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
    
    def authorisation_params
      params.require(:authorisation).permit(:provider, :uid, :token, :secret)
    end
  
end
