

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
  
  class << self
    
    def build_it_with_user(auth_hash)
    
      user = User.create(name: auth_hash['name'], email: auth_hash['email'])
      
      auth = create(user: user,
        provider: auth_hash[:provider],
        uid: auth_hash[:uid],
        token: auth_hash[:token],
        secret: auth_hash[:secret])
      
      auth
    end
    
    
  end
  
  def update(auth_hash)
    self.token = auth_hash[:token]
    self.secret = auth_hash[:secret]
    self.user.name = auth_hash['name']
    self.user.email = auth_hash['email']
    self.save!
  end
  
end
