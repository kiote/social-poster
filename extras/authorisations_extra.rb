
module AuthorisationsExtra
  
  
  def read_authhash(omniauth)
    
    authhash = Hash.new
    
    if ProvidersExtra::PROVIDERS.index(params[:provider])
      omniauth['provider'] ? authhash[:provider] = omniauth['provider'] : authhash[:provider] = ''
      omniauth['uid'] ? authhash[:uid] = omniauth['uid'].to_s : authhash[:uid] = ''
      omniauth['info']['name'] ? authhash["name"] =  omniauth['info']['name'] : authhash["name"] = ''
      omniauth['info']['email'] ? authhash["email"] =  omniauth['info']['email'] : authhash["email"] = ''
      
      omniauth['credentials']['token'] ? authhash[:token] =  omniauth['credentials']['token'] : authhash[:token] = ''
      omniauth['credentials']['secret'] ? authhash[:secret] =  omniauth['credentials']['secret'] : authhash[:secret] = ''
    end
    authhash
  end
  
end
