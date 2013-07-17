class Authorisation < ActiveRecord::Base  
  belongs_to :user
  validates :provider, :uid, presence: true
  
  validates :user_id, uniqueness: {scope: [:provider, :uid]}
  
  class << self    
    def build_it_with_user(auth_hash, current_user)
      user = User.create(name: auth_hash['name'], email: auth_hash['email'])
      
      current_user ||= User.find_by(session[:user_id])
      
      Rails.logger.debug "> biwu %s" % current_user
      
      auth = create(user: current_user,
        provider: auth_hash[:provider],
        uid: auth_hash[:uid],
        token: auth_hash[:token],
        secret: auth_hash[:secret])
      # а тебе не кажется, что после присваивания и так вернётся auth?
      auth
    end
  end
  
  #~ TODO: надо тест чтобы авторизация отдельно не создавалась
  
  def update(auth_hash)
    self.token = auth_hash[:token]
    self.secret = auth_hash[:secret]
    self.save!
  end
end
