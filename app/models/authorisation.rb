class Authorisation < ActiveRecord::Base
  belongs_to :user
  validates :provider, :uid, :presence => true
  
  #TODO:
  validates :user_id, :uniqueness => {:scope => [:provider, :uid]}
  
  #TODO: strong parameters
  attr_accessible :provider, :uid, :user
  attr_accessible :token, :secret
  
  def self.find_or_create(auth_hash)
    #TODO: raw_info et c parameters
    unless auth = find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])

      user = User.create :name => auth_hash["name"], :email => auth_hash["email"]
      
      auth = create :user => user,
        :provider => auth_hash[:provider],
        :uid => auth_hash[:uid],
        :token => auth_hash[:token],
        :secret => auth_hash[:secret]
    else
      #~ update token & secret
      auth.token = auth_hash[:token]
      auth.secret = auth_hash[:secret]
      auth.save!
    end
    
    auth
  end
  
end
