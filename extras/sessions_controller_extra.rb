
module SessionsControllerExtra
  
  
  def read_authhash(omniauth)
    
    @logger.debug("read_authhash")
    
    authhash = Hash.new
    
    #~ @logger.debug("%s" % omniauth.to_yaml)
    
    if params[:provider] == 'facebook'
    
      omniauth['extra']['raw_info']['email'] ? authhash[:email] =  omniauth['extra']['raw_info']['email'] : authhash[:email] = ''
      omniauth['extra']['raw_info']['name'] ? authhash[:name] =  omniauth['extra']['raw_info']['name'] : authhash[:name] = ''
      omniauth['extra']['raw_info']['id'] ?  authhash[:uid] =  omniauth['extra']['raw_info']['id'].to_s : authhash[:uid] = ''
      omniauth['provider'] ? authhash[:provider] = omniauth['provider'] : authhash[:provider] = ''
      
      @logger.debug("facebook's authhash")
      
      return authhash
      
    elsif ['twitter', 'linkedin', 'vkontakte'].index(params[:provider]) != nil
      omniauth['info']['email'] ? authhash[:email] =  omniauth['info']['email'] : authhash[:email] = ''
      omniauth['info']['name'] ? authhash[:name] =  omniauth['info']['name'] : authhash[:name] = ''
      omniauth['uid'] ? authhash[:uid] = omniauth['uid'].to_s : authhash[:uid] = ''
      omniauth['provider'] ? authhash[:provider] = omniauth['provider'] : authhash[:provider] = ''
      
      @logger.debug("else's authhash")
      
      return authhash
    
    
    else
      # TODO:
      @logger.debug("text's authhash")
      render :text => omniauth.to_yaml
      return
    end
  end
  
end
