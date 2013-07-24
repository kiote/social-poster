module SendMessageFunctions
  
  
  def send_message(user, message)
  
    sent_statuses = Array.new
    
    user.authorisations.each do |authorisation|
      send_to(authorisation, sent_statuses, message)
    end
    
    sent_statuses = sent_statuses.join(' ')
  end
  
  def send_to(authorisation, sent_statuses, message)
    
    provider = authorisation.provider
    
    if provider == 'twitter'
      sent_statuses << send_to_twitter(authorisation, message.text)
      
    elsif provider == 'facebook'
      sent_statuses << send_to_facebook(authorisation, message.text)
      
    elsif provider == 'linkedin'
      sent_statuses << send_to_linkedin(authorisation, message.text)
      
    elsif provider == 'vkontakte'
      sent_statuses << send_to_vkontakte(authorisation, message.text)
      
    elsif provider == 'tumblr'
      sent_statuses << send_to_tumblr(authorisation, message.text)
      
    else
      sent_statuses << 'nowhere to send'
    end
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
    
    "sent to vkontakte okay"
  end
    
  def send_to_tumblr(auth, text)
    "sent to tumblr okay"
  end

end
  
