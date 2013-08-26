
# TODO: это надо поностью менять, выделять отдельные классы для вконтакта, твиттера и тд
# когда начнем не токль слать сообещения но и например получать число лайков,
# тут будет хелл
# собственно он тут уже
# смотри в сторону Metaprogramming Ruby

require 'yaml'

module MessageSendersExtra
  
  class << self
  
    def create_submessages(params, message)
      facebook_message = CreateFacebookMessage.run(params[:facebook_message], message: message)
      linkedin_message = CreateLinkedinMessage.run(params[:linkedin_message], message: message)
      tumblr_message = CreateTumblrMessage.run(params[:tumblr_message], message: message)
      twitter_message = CreateTwitterMessage.run(params[:twitter_message], message: message)
      vkontakte_message = CreateVkontakteMessage.run(params[:vkontakte_message], message: message)
    end
    
    def send_messages(current_user, message)
      ms_fb = MessageSendersExtra::MessageSenderFacebook.new(current_user)
      ms_ln = MessageSendersExtra::MessageSenderLinkedin.new(current_user)
      ms_tu = MessageSendersExtra::MessageSenderTumblr.new(current_user)
      ms_tw = MessageSendersExtra::MessageSenderTwitter.new(current_user)
      ms_vk = MessageSendersExtra::MessageSenderVkontakte.new(current_user)
      
      sent_statuses = Array.new
      
      sent_statuses << ms_fb.send_message(message)
      sent_statuses << ms_ln.send_message(message)
      sent_statuses << ms_tu.send_message(message)
      sent_statuses << ms_tw.send_message(message)
      sent_statuses << ms_vk.send_message(message)
      
      sent_statuses = sent_statuses.join('; ')
    end
    
  end
  
  class MessageSender
    
    def initialize(user)
      @user = user
      @auth = nil
    end
    
    def send_message(message)
      #~ если пользователь авторизован у поставщика
      #~ и соответствующее сообщение не пусто
      #~ то отправить сообщение этому поставщику и вернуть результат отправки
    end
    
  end
  
  class MessageSenderFacebook < MessageSender
    
    def initialize(user)
      super(user)
      
      @user.authorisations.each do |auth|
        @auth = auth if auth.provider == 'facebook'
      end
    end
    
    def send_message(message)
      
      return "not authorised for facebook" if not @auth
      return "message for facebook is empty" if not message.facebook_message
      
      fb_user ||= FbGraph::User.me(@auth.token)
      response = fb_user.feed!(message: message.facebook_message.text)
      
      Rails.logger.debug '> %s' % response.inspect
      Rails.logger.debug '> okay'
      Rails.logger.debug '> t: %s, s: %s, u: %s' % [@auth.token, @auth.secret, @auth.uid]
      
      if response.message == message.facebook_message.text
        "facebook: created"
      else
        "facebook: failure"
      end
      
    end
    
  end
  
  class MessageSenderLinkedin < MessageSender
    
    def initialize(user)
      super(user)
      
      @user.authorisations.each do |auth|
        @auth = auth if auth.provider == 'linkedin'
      end
    end
    
    def send_message(message)
    
      return "not authorised for linkedin" if not @auth
      return "message for linkedin is empty" if not message.linkedin_message
        
      consumer_options = {
        request_token_path: "/uas/oauth/requestToken?scope=r_basicprofile+rw_nus",
        access_token_path: "/uas/oauth/accessToken",
        authorize_path: "/uas/oauth/authorize",
        api_host: "https://api.linkedin.com",
        auth_host: "https://www.linkedin.com"
      }
      
      client = LinkedIn::Client.new(APP_KEYS['linkedin']['consumer_key'], APP_KEYS['linkedin']['secret_key'], consumer_options)
      client.authorize_from_access(@auth.token, @auth.secret)
      
      response = client.add_share(comment: message.linkedin_message.text)
      Rails.logger.debug '> %s' % response.inspect
      Rails.logger.debug '> t: %s, s: %s, u: %s' % [@auth.token, @auth.secret, @auth.uid]
      
      if "#{response.inspect}".include? '201 Created'
        "linkedin: created"
      else
        "linkedin: failure"
      end
      
    end
  end

  class MessageSenderTumblr < MessageSender
    
    def initialize(user)
      super(user)
      
      @user.authorisations.each do |auth|
        @auth = auth if auth.provider == 'tumblr'
      end
    end
    
    def send_message(message)
      
      return "not authorised for tumblr" if not @auth
      return "message for tumblr is empty" if not message.tumblr_message
      
      consumer = OAuth::Consumer.new(APP_KEYS['tumblr']['consumer_key'], APP_KEYS['tumblr']['secret_key'], {:site => "http://www.tumblr.com/"})
      token_hash = { oauth_token: @auth.token, oauth_token_secret: @auth.secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
      
      response = access_token.post("http://api.tumblr.com/v2/blog/#{@auth.uid}.tumblr.com/post",
        {title: 'message from Social Poster', body: message.tumblr_message.text, type: 'text'})
      
      Rails.logger.debug '> %s' % response.body
      Rails.logger.debug '> t: %s, s: %s, u: %s' % [@auth.token, @auth.secret, @auth.uid]
      
      if response.body.include? '"status":201,"msg":"Created"'
        "tumblr: created"
      else
        "tumblr: failure"
      end
      
    end
    
  end

  class MessageSenderTwitter < MessageSender
    
    def initialize(user)
      super(user)
      
      @user.authorisations.each do |auth|
        @auth = auth if auth.provider == 'twitter'
      end
    end
    
    def send_message(message)
      
      return "not authorised for twitter" if not @auth
      return "message for twitter is empty" if not message.twitter_message
      
      consumer = OAuth::Consumer.new(APP_KEYS['twitter']['consumer_key'], APP_KEYS['twitter']['secret_key'], { :site => "http://api.twitter.com" })
      token_hash = { oauth_token: @auth.token, oauth_token_secret: @auth.secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
      response = access_token.request(:post, "http://api.twitter.com/1.1/statuses/update.json", status: message.twitter_message.text)
      
      Rails.logger.debug '> %s' % response.body
      Rails.logger.debug '> t: %s, s: %s, u: %s' % [@auth.token, @auth.secret, @auth.uid]
      
      if response.body.include? 'created_at'
        "twitter: created"
      else
        "twitter: failure"
      end
      
    end
    
  end

  class MessageSenderVkontakte < MessageSender
    
    def initialize(user)
      super(user)
      
      @user.authorisations.each do |auth|
        @auth = auth if auth.provider == 'vkontakte'
      end
    end
    
    def send_message(message)
      
      return "not authorised for vkontakte" if not @auth
      return "message for vkontakte is empty" if not message.vkontakte_message
      
      vk = VkontakteApi::Client.new @auth.token
      Rails.logger.debug "---===+++++++"
      #~ vk.wall.post(message: text)
      Rails.logger.debug "token %s" % @auth.token
      Rails.logger.debug "secret %s" % @auth.secret
      Rails.logger.debug "---===++++++++"
      
      # TODO: really its not
      "vkontakte: created"
    end
  end

end
