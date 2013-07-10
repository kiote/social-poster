class Authorisation < ActiveRecord::Base
  belongs_to :user
  validates :provider, :uid, presence: true
  
  #TODO:
  validates :user_id, uniqueness: {scope: [:provider, :uid]}
  
  #TODO: strong parameters
  attr_accessible :provider, :uid, :user
  attr_accessible :token, :secret
  
  # какой-то неудачный метод и его название
  # называется find_or_create и заодно делает update
  # кострукции вида unless .. else .. end лучше не использовать - перейти на if .. else .. end (проще для понимания)
  # если у метода параметров больше одного, нужно ставить скобки
  def self.find_or_create(auth_hash)
    unless auth = find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])

      user = User.create(name: auth_hash['name'], email: auth_hash['email'])
      
      auth = create(user: user,
        provider: auth_hash[:provider],
        uid: auth_hash[:uid],
        token: auth_hash[:token],
        secret: auth_hash[:secret])
    else
      #~ update token & secret
      auth.token = auth_hash[:token]
      auth.secret = auth_hash[:secret]
      auth.save!
    end
    
    auth
  end
  
end
