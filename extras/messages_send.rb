module MessagesSend

  class Message < Struct.new(:text, :token, :secret)
    def send
      throw 'you should inherit this class'
    end
  end
  
  class MessageTwitter < Message
    def send
      consumer = OAuth::Consumer.new(APP_KEYS['twitter']['app_key'], APP_KEYS['twitter']['app_secret'], { :site => "http://api.twitter.com" })
      token_hash = { oauth_token: @token, oauth_token_secret: @secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
      response = access_token.request(:post, "http://api.twitter.com/1.1/statuses/update.json", status: @text)
    end
  end
  
  class MessageFacebook < Message
    def send
      fb_user ||= FbGraph::User.me(@token)
      fb_user.feed!(message: @text, name: 'feed_name')
    end
  end
  
  class MessageLinkedin < Message
    def send
      consumer_options = {
        request_token_path: "/uas/oauth/requestToken?scope=r_basicprofile+rw_nus",
        access_token_path: "/uas/oauth/accessToken",
        authorize_path: "/uas/oauth/authorize",
        api_host: "https://api.linkedin.com",
        auth_host: "https://www.linkedin.com"
      }
      
      client = LinkedIn::Client.new(APP_KEYS['linkedin']['app_key'], APP_KEYS['linkedin']['app_secret'], consumer_options)
      client.authorize_from_access(@token, @secret)
   
      Rails.logger.debug "---==="
      Rails.logger.debug "%s" % client.profile
      Rails.logger.debug "---==="
      
      client.add_share(comment: @text)
    end
  end
  
  class MessageVkontakte < Message
    def send
      vk = VkontakteApi::Client.new @token
      Rails.logger.debug "---===+++++++"
      #~ vk.wall.post(message: @text)
      Rails.logger.debug "token %s" % @token
      Rails.logger.debug "secret %s" % @secret
      Rails.logger.debug "---===++++++++"
    end
  end

end
  
