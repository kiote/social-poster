
# TODO: это надо поностью менять, выделять отдельные классы для вконтакта, твиттера и тд
# когда начнем не токль слать сообещения но и например получать число лайков,
# тут будет хелл
# собственно он тут уже
# смотри в сторону Metaprogramming Ruby

require 'yaml'

module MessageSendersExtra
  
  class << self
    
    def do_send_message(message)
      #~ проверить какие подсообщения сообщения не пусты
      #~ проверить авторизована ли отправка для этих подсообщений
      #~ отправить сообщение, вернуть что-то типа кодоа ошибки
      
      send_results = {}
      
      ProvidersExtra::PROVIDERS.each do |provider|
        
        if message.send(:"#{provider}_message") == nil
          next
        end
        
        if message.user.authorisations.find_by_provider(provider) == nil
          next
        end
        
        send_results[:"#{provider}"] = self.send(:"send_message_to_#{provider}", message)
        
      end
      
      return send_results
      
    end
    
    def send_message_to_facebook(message)
      
      auth = message.user.authorisations.find_by_provider(:facebook)
      
      begin
        fb_user ||= FbGraph::User.me(auth.token)
        response = fb_user.feed!(message: message.facebook_message.text)
      rescue Exception => e
        damn = "facebook message publicity error: %s " % e.message
        return damn
      end
      
      if response
        if response.message == message.facebook_message.text
          "facebook: created"
        else
          "facebook: something wrong: %s" % response.inspect
        end          
      end
      
    end
    
    def send_message_to_linkedin(message)
      
      auth = message.user.authorisations.find_by_provider(:linkedin)
      
      consumer_options = MISC_PARAMS['linkedin']['consumer_options']
      
      client = LinkedIn::Client.new(APP_KEYS['linkedin']['consumer_key'], APP_KEYS['linkedin']['secret_key'], consumer_options)
      client.authorize_from_access(auth.token, auth.secret)
      
      response = client.add_share(comment: message.linkedin_message.text)
      
      if "#{response.inspect}".include? '201 Created'
        "linkedin: created"
      else
        "linkedin: something wrong: %s" % response.inspect
      end
    end
    
    def send_message_to_tumblr(message)

      auth = message.user.authorisations.find_by_provider(:tumblr)
      
      consumer = OAuth::Consumer.new(APP_KEYS['tumblr']['consumer_key'], APP_KEYS['tumblr']['secret_key'], {site: MISC_PARAMS['tumblr']['site']})
      token_hash = { oauth_token: auth.token, oauth_token_secret: auth.secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
      
      #MISC_PARAMS['tumblr']['post_to_url'],
      
      response = access_token.post("http://api.tumblr.com/v2/blog/#{auth.uid}.tumblr.com/post",
        {title: 'a message from Social Poster', body: message.tumblr_message.text, type: 'text'})
      
      if response.body.include? '"status":201,"msg":"Created"'
        "tumblr: created"
      else
        "tumblr: something wrong: %s" % response.body.inspect
      end
    end
    
    def send_message_to_twitter(message)
      
      auth = message.user.authorisations.find_by_provider(:twitter)
      
      consumer = OAuth::Consumer.new(APP_KEYS['twitter']['consumer_key'], APP_KEYS['twitter']['secret_key'], { site: MISC_PARAMS['twitter']['site'] })
      
      token_hash = { oauth_token: auth.token, oauth_token_secret: auth.secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash)

      response = access_token.request(:post, MISC_PARAMS['twitter']['post_to_url'], status: message.twitter_message.text)
      
      if response.body.include? 'created_at'
        "twitter: created"
      else
        "twitter: something wrong: %s" % response.body.inspect
      end        
      
    end
    
  end

end
