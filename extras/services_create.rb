
module ServicesCreate
  
  # This handles signing in and adding an authentication service to existing accounts itself
  # It renders a separate view if there is a new user to create
  def create
    @logger.debug "services_controller: create"
    
    # get the service parameter from the Rails router
    params[:service] ? service_route = params[:service] : service_route = 'No service recognized (invalid callback)'

    # get the full hash from omniauth
    omniauth = request.env['omniauth.auth']
    
    # continue only if hash and parameter exist
    if !(omniauth and params[:service])
      msg = 'Error while authenticating via ' + service_route.capitalize + '. The service did not return valid data.'
      @logger.debug "%s" % msg
      flash[:error] = msg
      redirect_to signin_path
    end

    # map the returned hashes to our variables first - the hashes differs for every service
    
    read_authhash(omniauth)
    
    if !(@authhash[:uid] != '' and @authhash[:provider] != '')
      msg = 'Error while authenticating via ' + service_route + '/' + @authhash[:provider].capitalize + '. The service returned invalid data for the user id.'
      @logger.debug "%s" % msg
      flash[:error] = msg
      redirect_to signin_path
    end
    
    
    authorisation = Service.find_by_provider_and_uid(@authhash[:provider], @authhash[:uid])
    
    # if the user is currently signed in, he/she might want to add another account to signin
    if user_signed_in?
      
      if authorisation
        
        msg = "Your account at %s is already connected with this site." % @authhash[:provider].capitalize
        flash[:notice] = msg
        @logger.debug "%s" % msg        
        
        render :text => "%s" % msg
      
      end
      
      if !authorisation
        current_user.services.create!(:provider => @authhash[:provider], :uid => @authhash[:uid], :uname => @authhash[:name], :uemail => @authhash[:email])
        
        msg = "Your %s account has been added for signing in at this site." % @authhash[:provider].capitalize
        flash[:notice] = msg        
        @logger.debug "%s" % msg
        
        render :text => "%s" % msg
      end
      
    end

    if !user_signed_in?
      if authorisation
        # signin existing user
        # in the session his user id and the service id used for signing in is stored
        session[:user_id] = authorisation.user.id
        session[:service_id] = authorisation.id
        
        msg = 'Signed in successfully via ' + @authhash[:provider].capitalize + '.'
        @logger.debug "%s" % msg
        
        flash[:notice] = msg
        
        #~ redirect_to root_url
        session[:authhash] = @authhash
        #~ redirect_to "send_message#index"
        render :text => "%s" % msg
      end
      
      if !authorisation
        # this is a new user; show signup; @authhash is available to the view and stored in the sesssion for creation of a new user
        session[:authhash] = @authhash
        render signup_services_path
      end
    end
  
  end
  
  def read_authhash(omniauth)
    # create a new hash
    
    @authhash = Hash.new
    
    @logger.debug "omniauth_hash: %s" % omniauth.to_xml
    
    if params[:service] == 'facebook'
    
      omniauth['extra']['raw_info']['email'] ? @authhash[:email] =  omniauth['extra']['raw_info']['email'] : @authhash[:email] = ''
      omniauth['extra']['raw_info']['name'] ? @authhash[:name] =  omniauth['extra']['raw_info']['name'] : @authhash[:name] = ''
      omniauth['extra']['raw_info']['id'] ?  @authhash[:uid] =  omniauth['extra']['raw_info']['id'].to_s : @authhash[:uid] = ''
      omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''
      
      
    elsif ['twitter', 'linkedin', 'vkontakte'].index(params[:service]) != nil
      omniauth['info']['email'] ? @authhash[:email] =  omniauth['info']['email'] : @authhash[:email] = ''
      omniauth['info']['name'] ? @authhash[:name] =  omniauth['info']['name'] : @authhash[:name] = ''
      omniauth['uid'] ? @authhash[:uid] = omniauth['uid'].to_s : @authhash[:uid] = ''
      omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''
    
    
    else
      # debug to output the hash that has been returned when adding new services
      render :text => omniauth.to_yaml
      @logger.debug "omniauth_hash: %s" % omniauth.to_xml
      return
    end
  end
  
end
