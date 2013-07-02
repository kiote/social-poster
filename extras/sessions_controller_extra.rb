
module SessionsControllerExtra
  
  
  def read_authhash(omniauth)
    
    authhash = Hash.new
    
    if params[:provider] == 'facebook'
    
      omniauth['extra']['raw_info']['email'] ? authhash[:email] =  omniauth['extra']['raw_info']['email'] : authhash[:email] = ''
      omniauth['extra']['raw_info']['name'] ? authhash[:name] =  omniauth['extra']['raw_info']['name'] : authhash[:name] = ''
      omniauth['extra']['raw_info']['id'] ?  authhash[:uid] =  omniauth['extra']['raw_info']['id'].to_s : authhash[:uid] = ''
      omniauth['provider'] ? authhash[:provider] = omniauth['provider'] : authhash[:provider] = ''
      
      return authhash
      
    elsif ['twitter', 'linkedin', 'vkontakte'].index(params[:provider]) != nil
      omniauth['info']['email'] ? authhash[:email] =  omniauth['info']['email'] : authhash[:email] = ''
      omniauth['info']['name'] ? authhash[:name] =  omniauth['info']['name'] : authhash[:name] = ''
      omniauth['uid'] ? authhash[:uid] = omniauth['uid'].to_s : authhash[:uid] = ''
      omniauth['provider'] ? authhash[:provider] = omniauth['provider'] : authhash[:provider] = ''
      
      return authhash
    
    
    else
      # TODO:
      render :text => omniauth.to_yaml
      return
    end
  end
  
end
