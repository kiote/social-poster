
# TODO: это надо поностью менять, выделять отдельные классы для вконтакта, твиттера и тд
# когда начнем не токль слать сообещения но и например получать число лайков,
# тут будет хелл
# собственно он тут уже
# смотри в сторону Metaprogramming Ruby

require 'yaml'

module MessageSendersExtra
  
  class << self
    
    def send_message(message)
      #~ проверить какие подсообщения сообщения не пусты
      #~ проверить авторизована ли отправка для этих подсообщений
      #~ отправить сообщение, вернуть что-то типа кодоа ошибки
      
      ProvidersExtra::PROVIDERS.each do |provider|
        
        if message.send(:"#{provider}_message") == nil
          next
        end
        
        if message.user.authorisations.find_by_provider(provider) == nil
          next
        end
        
        self.send(:"send_message_to_#{provider}", message)
        
      end
      
    end
    
    
    
    def send_message_to_facebook message
      
      auth = message.user.authorisations.find_by_provider(:facebook)
      
      fb_user ||= FbGraph::User.me(auth.token)
      response = fb_user.feed!(message: message.facebook_message.text)
      
      if response.message == message.facebook_message.text
        "facebook: created"
      else
        "facebook: failure"
      end
      
    end
    
    def send_message_to_linkedin
      
      auth = message.user.authorisations.find_by_provider(:linkedin)
      
      consumer_options = {
        request_token_path: "/uas/oauth/requestToken?scope=r_basicprofile+rw_nus",
        access_token_path: "/uas/oauth/accessToken",
        authorize_path: "/uas/oauth/authorize",
        api_host: "https://api.linkedin.com",
        auth_host: "https://www.linkedin.com"
      }
      
      client = LinkedIn::Client.new(APP_KEYS['linkedin']['consumer_key'], APP_KEYS['linkedin']['secret_key'], consumer_options)
      client.authorize_from_access(auth.token, auth.secret)
      
      response = client.add_share(comment: message.linkedin_message.text)
      
      if "#{response.inspect}".include? '201 Created'
        "linkedin: created"
      else
        "linkedin: failure"
      end
    end
    
    def send_message_to_tumblr

      auth = message.user.authorisations.find_by_provider(:tumblr)
      
      consumer = OAuth::Consumer.new(APP_KEYS['tumblr']['consumer_key'], APP_KEYS['tumblr']['secret_key'], {:site => "http://www.tumblr.com/"})
      token_hash = { oauth_token: auth.token, oauth_token_secret: auth.secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
      
      response = access_token.post("http://api.tumblr.com/v2/blog/#{auth.uid}.tumblr.com/post",
        {title: 'message from Social Poster', body: message.tumblr_message.text, type: 'text'})
      
      if response.body.include? '"status":201,"msg":"Created"'
        "tumblr: created"
      else
        "tumblr: failure"
      end
    end
    
    def send_message_to_twitter
      
      auth = message.user.authorisations.find_by_provider(:twitter)
      
      consumer = OAuth::Consumer.new(APP_KEYS['twitter']['consumer_key'], APP_KEYS['twitter']['secret_key'], { :site => "http://api.twitter.com" })
      token_hash = { oauth_token: auth.token, oauth_token_secret: auth.secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
      response = access_token.request(:post, "http://api.twitter.com/1.1/statuses/update.json", status: message.twitter_message.text)
      
      Rails.logger.debug '> %s' % response.body
      Rails.logger.debug '> t: %s, s: %s, u: %s' % [auth.token, auth.secret, auth.uid]
      
      if response.body.include? 'created_at'
        "twitter: created"
      else
        "twitter: failure"
      end
    end
    
    def send_message_to_vkontakte
      
      auth = message.user.authorisations.find_by_provider(:vkontakte)
      
      vk = VkontakteApi::Client.new auth.token
      vk.wall.post(message: text)
    end
    
  end

end
