
module SendMessageFunctions
  
  
  #~ TODO:
  def send_message(message, user)
    
    auth_providers = Array.new

    fb_auth = nil
    tw_auth = nil
    tu_auth = nil
    ln_auth = nil
    vk_auth = nil


    # todo: User should have meth "facebook_auth?" .. "twitter_auth?"
    user.authorisations.each do |auth|
      fb_auth = auth if auth.provider == "facebook"
      tw_auth = auth if auth.provider == "twitter"
      tu_auth = auth if auth.provider == "tumblr"
      ln_auth = auth if auth.provider == "linkedin"
      vk_auth = auth if auth.provider == "vkontakte"
    end
    
    Rails.logger.debug fb_auth
    Rails.logger.debug tw_auth
    Rails.logger.debug tu_auth
    Rails.logger.debug ln_auth
    Rails.logger.debug vk_auth
    
    sent_statuses = Array.new
    
    if message.facebook_message and fb_auth
      sent_statuses << send_to_facebook(fb_auth, message.facebook_message.text)
    end
    
    if message.twitter_message and tw_auth
      sent_statuses << send_to_twitter(tw_auth, message.twitter_message.text)
    end
    
    if message.linkedin_message and ln_auth
      sent_statuses << send_to_linkedin(ln_auth, message.linkedin_message.text)
    end
    
    if message.vkontakte_message and vk_auth
      sent_statuses << send_to_vkontakte(vk_auth, message.vkontakte_message.text)
    end
    
    if message.tumblr_message and tu_auth
      sent_statuses << send_to_tumblr(tu_auth, message.tumblr_message.text)
    end
    
    sent_statuses = sent_statuses.join(' ')
  end
  
  def send_to_twitter(auth, text)
    consumer = OAuth::Consumer.new(APP_KEYS['twitter']['consumer_key'], APP_KEYS['twitter']['secret_key'], { :site => "http://api.twitter.com" })
    token_hash = { oauth_token: auth.token, oauth_token_secret: auth.secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
    response = access_token.request(:post, "http://api.twitter.com/1.1/statuses/update.json", status: text)
    
    "sent to twitter probably okay"
  end
  
  def send_to_tumblr(auth, text)
    consumer = OAuth::Consumer.new(APP_KEYS['tumblr']['consumer_key'], APP_KEYS['tumblr']['secret_key'], {:site => "http://www.tumblr.com/"})
    token_hash = { oauth_token: auth.token, oauth_token_secret: auth.secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
    
    response = access_token.post("http://api.tumblr.com/v2/blog/#{auth.uid}.tumblr.com/post",
      {title: 'title', body: 'body', type: 'text'})
    "sent to tumblr probably okay"
  end
    
  def send_to_facebook(auth, text)
    fb_user ||= FbGraph::User.me(auth.token)
    fb_user.feed!(message: text, name: 'feed_name')
    
    "sent to facebook okay"
  end
  
  def send_to_linkedin(auth, text)
    consumer_options = {
      request_token_path: "/uas/oauth/requestToken?scope=r_basicprofile+rw_nus",
      access_token_path: "/uas/oauth/accessToken",
      authorize_path: "/uas/oauth/authorize",
      api_host: "https://api.linkedin.com",
      auth_host: "https://www.linkedin.com"
    }
    
    client = LinkedIn::Client.new(APP_KEYS['linkedin']['consumer_key'], APP_KEYS['linkedin']['secret_key'], consumer_options)
    client.authorize_from_access(auth.token, auth.secret)
 
    Rails.logger.debug "---==="
    Rails.logger.debug "%s" % client.profile
    Rails.logger.debug "---==="
    
    client.add_share(comment: text)
    
    "sent to linkedin okay"
  end
  
  def send_to_vkontakte(auth, text)
    vk = VkontakteApi::Client.new auth.token
    Rails.logger.debug "---===+++++++"
    #~ vk.wall.post(message: text)
    Rails.logger.debug "token %s" % auth.token
    Rails.logger.debug "secret %s" % auth.secret
    Rails.logger.debug "---===++++++++"
    
    "sent to vkontakte under construction"
  end

end
  
