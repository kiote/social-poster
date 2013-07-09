  #~ following code taken from this source
  #~ http://superp.tumblr.com/post/4109090091/publish-stream-in-facebook-twitter-with-omniauth
  
  serialize :auth_hash, Hash
  
  def facebook
    @fb_user ||= FbGraph::User.me(user_attributes[:token])
  end
  
  def twitter
    @tw_user ||= prepare_access_token(user_attributes[:token], user_attributes[:secret])
  end
  
  def publish(text, feed_name)
    begin
      case self.provider
       when 'facebook' then facebook.feed!(:message => text, :name => feed_name)
       when 'twitter' then twitter.request(:post, "http://api.twitter.com/1/statuses/update.json", :status => text)
      end
    rescue Exception => e
    end
  end
 
  def user_attributes
    @user_attributes ||= extract_user_attributes(auth_hash)
  end
 
  protected
 
    def extract_user_attributes(hash)
      user_credentials = hash['credentials'] || {}
      user_info = hash['user_info'] || {}
      user_hash = hash['extra'] ? (hash['extra']['user_hash'] || {}) : {}
      
      { 
        :token => user_credentials['token'],
        :secret => user_credentials['secret'],
        :name => user_info['name'], 
        :email => (user_info['email'] || user_hash['email']),
        :nickname => user_info['nickname'],
        :last_name => user_info['last_name'],
        :first_name => user_info['first_name'],
        :link => (user_info['link'] || user_hash['link']),
        :photo_url => (user_info['image'] || user_hash['image']),
        :locale => (user_info['locale'] || user_hash['locale']),
        :description => (user_info['description'] || user_hash['description'])
      }
    end
 
    def prepare_access_token(oauth_token, oauth_token_secret)
      consumer = OAuth::Consumer.new("CONSUMER_KEY", "CONSUMER_SECRET", { :site => "http://api.twitter.com" })
      # now create the access token object from passed values
      token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
      return access_token
    end
