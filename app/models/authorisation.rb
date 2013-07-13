class Authorisation < ActiveRecord::Base  
  belongs_to :user
  validates :provider, :uid, presence: true
  
  validates :user_id, uniqueness: {scope: [:provider, :uid]}
  
  class << self    
    def build_it_with_user(auth_hash)
      user = User.create(name: auth_hash['name'], email: auth_hash['email'])
      
      auth = create(user: user,
        provider: auth_hash[:provider],
        uid: auth_hash[:uid],
        token: auth_hash[:token],
        secret: auth_hash[:secret])
      # а тебе не кажется, что после присваивания и так вернётся auth?
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
