class Authorisation < ActiveRecord::Base
  belongs_to :user
  validates :provider, :uid, :presence => true
  
  #TODO: strong parameters
  attr_accessible :provider, :uid
  
  
  def self.find_or_create(auth_hash)
    #TODO: raw_info et c parameters
    unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      user = User.create :name => auth_hash["user_info"]["name"], :email => auth_hash['extra']['raw_info']["email"]
      auth = create :user => user, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
    
    auth
  end
  
  
end
