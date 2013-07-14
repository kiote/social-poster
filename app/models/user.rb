
class User < ActiveRecord::Base
  
  has_many :authorisations
  
  has_secure_password
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX},
    uniqueness: true
  
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  
  def add_authorisation(auth_hash)
  
    # Check if the provider already exists, so we don't add it twice
    
    auth = authorisations.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])
    
    if auth == nil
      auth = authorisations.create :provider => auth_hash[:provider],
        :uid => auth_hash[:uid],
        :token => auth_hash[:token],
        :secret => auth_hash[:secret]      
    end
    
  end
  
  def update_info(auth_hash)
    
    auth = authorisations.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])
    
    auth.token = auth_hash[:token]
    auth.secret = auth_hash[:secret]
    auth.save!
    
    self.name = auth_hash['name']
    self.email = auth_hash['email']
    self.save!
    
  end
  
  
end
