
class User < ActiveRecord::Base
  
  has_many :authorisations
  
  #TODO: strong parameters
  attr_accessible :name, :email
  
  def add_provider(auth_hash)
  
    # Check if the provider already exists, so we don't add it twice
    
    unless auth = authorisations.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])
      auth = authorisations.create :provider => auth_hash[:provider],
        :uid => auth_hash[:uid],
        :token => auth_hash[:token],
        :secret => auth_hash[:secret]
      else
        #~ update token & secret
        auth.token = auth_hash[:token]
        auth.secret = auth_hash[:secret]
        auth.save!
    end
  end
  
  
end
