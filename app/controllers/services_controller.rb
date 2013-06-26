class ServicesController < ApplicationController
  
  layout "social_poster"
  
  before_filter :authenticate_user!, :except => [:create, :signin, :signup, :newaccount, :failure]
  protect_from_forgery :except => :create
  
  before_filter :set_logger
  def set_logger
    @logger = Logger.new("services.log")
    @logger.formatter = proc do |severity, datetime, progname, msg|
      "> #{msg}\n"
    end
  end

  # GET all authentication services assigned to the current user
  def index
    @services = current_user.services.order('provider asc')
    
    @services.each do |service|
      msg = "signed with: %s" % service.provider
      @logger.debug "services_controller, index: %s" % msg
    end
    
  end

  # POST to remove an authentication service
  def destroy
    # remove an authentication service linked to the current user
    @service = current_user.services.find(params[:id])
    
    if session[:service_id] == @service.id
      flash[:error] = 'You are currently signed in with this account!'
      msg = 'You are currently signed in with this account!'
      @logger.debug "services_controller: newaccount: %s" % msg
    else
      @service.destroy
    end
    
    redirect_to services_path
  end

  # POST from signup view
  def newaccount
    if params[:commit] == "Cancel"
      session[:authhash] = nil
      session.delete :authhash
      redirect_to root_url
    else  # create account
      @newuser = User.new
      @newuser.name = session[:authhash][:name]
      @newuser.email = session[:authhash][:email]
      @newuser.services.build(:provider => session[:authhash][:provider], :uid => session[:authhash][:uid], :uname => session[:authhash][:name], :uemail => session[:authhash][:email])
      
      if @newuser.save!
        # signin existing user
        # in the session his user id and the service id used for signing in is stored
        session[:user_id] = @newuser.id
        session[:service_id] = @newuser.services.first.id
        
        flash[:notice] = 'Your account has been created and you have been signed in!'
        
        msg = 'Your account has been created and you have been signed in!'
        @logger.debug "services_controller: newaccount: %s" % msg
        
        redirect_to root_url
      else
        msg = 'This is embarrassing! There was an error while creating your account from which we were not able to recover.'
        @logger.debug "services_controller: newaccount: %s" % msg
        
        flash[:error] = 'This is embarrassing! There was an error while creating your account from which we were not able to recover.'
        redirect_to root_url
      end  
    end
  end  
  
  # Sign out current user
  def signout 
    if current_user
      session[:user_id] = nil
      session[:service_id] = nil
      session.delete :user_id
      session.delete :service_id
      flash[:notice] = 'You have been signed out!'
      
      @logger.debug "services_controller: create: %s" % flash[:notice]
      
    end
    
    redirect_to root_url
  end
  
  # callback: success
  # This handles signing in and adding an authentication service to existing accounts itself
  # It renders a separate view if there is a new user to create
  def create
    # get the service parameter from the Rails router
    params[:service] ? service_route = params[:service] : service_route = 'No service recognized (invalid callback)'

    # get the full hash from omniauth
    omniauth = request.env['omniauth.auth']
    
    # continue only if hash and parameter exist
    if omniauth and params[:service]

      # map the returned hashes to our variables first - the hashes differs for every service
      
      # create a new hash
      @authhash = Hash.new
      
      @logger.debug "omniauth_hash: %s" % omniauth.to_xml
      
      if service_route == 'facebook'
        omniauth['extra']['raw_info']['email'] ? @authhash[:email] =  omniauth['extra']['raw_info']['email'] : @authhash[:email] = ''
        omniauth['extra']['raw_info']['name'] ? @authhash[:name] =  omniauth['extra']['raw_info']['name'] : @authhash[:name] = ''
        omniauth['extra']['raw_info']['id'] ?  @authhash[:uid] =  omniauth['extra']['raw_info']['id'].to_s : @authhash[:uid] = ''
        omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''
        
        
      elsif ['twitter', 'linkedin', 'vkontakte'].index(service_route) != nil
        omniauth['info']['email'] ? @authhash[:email] =  omniauth['info']['email'] : @authhash[:email] = ''
        omniauth['info']['name'] ? @authhash[:name] =  omniauth['info']['name'] : @authhash[:name] = ''
        omniauth['uid'] ? @authhash[:uid] = omniauth['uid'].to_s : @authhash[:uid] = ''
        omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''
      
      
      else
        # debug to output the hash that has been returned when adding new services
        render :text => omniauth.to_yaml
        return
      end 
      
      if @authhash[:uid] != '' and @authhash[:provider] != ''
        
        auth = Service.find_by_provider_and_uid(@authhash[:provider], @authhash[:uid])
        
        # if the user is currently signed in, he/she might want to add another account to signin
        if user_signed_in?
          if auth
            
            msg = 'Your account at ' + @authhash[:provider].capitalize + ' is already connected with this site.'
            @logger.debug "services_controller: create: %s" % msg
            
            flash[:notice] = 'Your account at ' + @authhash[:provider].capitalize + ' is already connected with this site.'
            
            #~ redirect_to services_path
            redirect_somewhere_or_render_something
          else
            current_user.services.create!(:provider => @authhash[:provider], :uid => @authhash[:uid], :uname => @authhash[:name], :uemail => @authhash[:email])
            flash[:notice] = 'Your ' + @authhash[:provider].capitalize + ' account has been added for signing in at this site.'
            
            msg = flash[:notice]
            @logger.debug "services_controller: create: %s" % msg
            
            #~ redirect_to services_path
            redirect_somewhere_or_render_something
          end
        else
          if auth
            # signin existing user
            # in the session his user id and the service id used for signing in is stored
            session[:user_id] = auth.user.id
            session[:service_id] = auth.id
            
            msg = 'Signed in successfully via ' + @authhash[:provider].capitalize + '.'
            @logger.debug "services_controller: create: %s" % msg
            
            flash[:notice] = msg
            
            #~ redirect_to root_url
            redirect_somewhere_or_render_something
          else
            # this is a new user; show signup; @authhash is available to the view and stored in the sesssion for creation of a new user
            session[:authhash] = @authhash
            render signup_services_path
          end
        end
      else
        msg = 'Error while authenticating via ' + service_route + '/' + @authhash[:provider].capitalize + '. The service returned invalid data for the user id.'
        @logger.debug "services_controller: create: %s" % msg
        flash[:error] = msg
        redirect_to signin_path
      end
    else
      msg = 'Error while authenticating via ' + service_route.capitalize + '. The service did not return valid data.'
      @logger.debug "services_controller: create: %s" % msg
      flash[:error] = msg
      redirect_to signin_path
    end
  end
  
  # callback: failure
  def failure
    flash[:error] = 'There was an error at the remote authentication service. You have not been signed in.'
    @logger.debug "services_controller: failure"
    redirect_to root_url
  end
  
  #~ может быть для этого надо специальный контроллер?
  
  def signed_in_with
    services = current_user.services.order('provider asc')
    provider = ''
    
    services.each do |service|
      provider = service.provider if session[:service_id] == service.id
    end
    provider
  end
  
  def current_user_providers
    services = current_user.services.order('provider asc')
    providers = Array.new
    
    services.each do |service|
      providers << service.provider
    end
    providers
  end
  
  def redirect_somewhere_or_render_something
    
    @logger.debug "redirect_somewhere_or_render_something"
    @logger.debug "signed_in_with %s" % signed_in_with
    
    #~ ага, похоже пользователю достаточно быть авторизованным
    #~ на сервисе, не обязательно signin
    #~ значит, допускается на вкладку авторизованного провайдера
    #~ либо отправляется авторизоваться
    
    if signed_in_with == 'facebook'
      @logger.debug "redirect_to services#send_facebook"
      send_facebook
      
    elsif signed_in_with == 'twitter'
      @logger.debug "redirect_to services/send_twitter"
      send_twitter
      
    elsif signed_in_with == 'linkedin'
      @logger.debug "redirect_to services/send_linkedin"
      send_linkedin
      
    elsif signed_in_with == 'vkontakte'
      @logger.debug "redirect_to services/send_vkontakte"
      send_vkontakte
      
    else
      render :text => "nowhere i want to go"
    end
    
  end
  
  def send_facebook
  
    @logger.debug "send_facebook;"
    @logger.debug "signed_in_with %s" % signed_in_with
    providers = current_user_providers
    is_that = providers.include? 'facebook'
    @logger.debug "current_user_providers.contains %s" % is_that
    
    if not current_user_providers.include? 'facebook'
      redirect_to "/auth/facebook"
    else
      render "/services/send_facebook"
    end
    #~ if signed_in_with != 'facebook'
      #~ session[:user_id] = nil
      #~ session[:service_id] = nil
      #~ session.delete :user_id
      #~ session.delete :service_id
      #~ 
      #~ redirect_to "/services/send_facebook"
    #~ end
  end
  
  def send_twitter
    
    @logger.debug "send_twitter;"
    @logger.debug "signed_in_with %s" % signed_in_with
    providers = current_user_providers
    puts providers
    is_that = providers.include? 'twitter'
    @logger.debug "current_user_providers.contains %s" % is_that
    
    if not current_user_providers.include? 'twitter'
      redirect_to "/auth/twitter"
    else
      render "/services/send_twitter"
    end
    #~ if signed_in_with != 'twitter'
      #~ session[:user_id] = nil
      #~ session[:service_id] = nil
      #~ session.delete :user_id
      #~ session.delete :service_id
      #~ 
      #~ redirect_to "/services/send_twitter"
    #~ end
  end
  
  def send_linkedin
    
    @logger.debug "send_linkedin;"
    @logger.debug "signed_in_with %s" % signed_in_with
    providers = current_user_providers
    is_that = providers.include? 'linkedin'
    @logger.debug "current_user_providers.contains %s" % is_that
    
    if not current_user_providers.include? 'linkedin'
      redirect_to "/auth/linkedin"
    else
      render "/services/send_linkedin"
    end
    #~ if signed_in_with != 'linkedin'
      #~ session[:user_id] = nil
      #~ session[:service_id] = nil
      #~ session.delete :user_id
      #~ session.delete :service_id
      #~ 
      #~ redirect_to "/services/send_linkedin"
    #~ end
  end
  
  def send_vkontakte
    
    @logger.debug "send_vkontakte;"
    @logger.debug "signed_in_with %s" % signed_in_with
    providers = current_user_providers
    is_that = providers.include? 'vkontakte'
    @logger.debug "current_user_providers.contains %s" % is_that
    
    if not current_user_providers.include? 'vkontakte'
      redirect_to "/auth/vkontakte"
    else
      render "/services/send_vkontakte"
    end
    #~ if signed_in_with != 'vkontakte'
      #~ session[:user_id] = nil
      #~ session[:service_id] = nil
      #~ session.delete :user_id
      #~ session.delete :service_id
      #~ 
      #~ redirect_to "/auth/vkontakte"
    #~ end
    
  end
  
end
