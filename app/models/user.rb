
class User < ActiveRecord::Base
  
  has_many :authorisations, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  has_secure_password validations: false
  
  # TODO: validations to mutations
  
  #~ VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #~ validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  
  #~ validates :password, presence: true, length: { minimum: 5 }
  #~ validates :password_confirmation, presence: true
  
  before_create :create_remember_token
  
  before_save { self.email = email.downcase }
  
  class << self
    def new_remember_token
      SecureRandom.urlsafe_base64
    end
    
    def encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
    
  end
  
  private
    
    def create_remember_token
      self.remember_me = User.encrypt(User.new_remember_token)
    end
    
    def password_confirmation
      return true
    end
end
