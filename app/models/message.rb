
class Message < ActiveRecord::Base
  
  belongs_to :user
  
  has_one :twitter_message, dependent: :destroy
  has_one :facebook_message, dependent: :destroy
  has_one :linkedin_message, dependent: :destroy
  has_one :tumblr_message, dependent: :destroy
  has_one :twitter_message, dependent: :destroy
  has_one :vkontakte_message, dependent: :destroy
  
  validates :user_id, presence: true
  default_scope -> { order('created_at DESC') }
  
  before_save { sent_at = Time.new }
  
  def build_texts(params)
    ProvidersExtra::PROVIDERS.each do |provider|
      next if params[:"#{provider}_message"][:text].length == 0
      self.send(:"build_#{provider}_message", text: params[:"#{provider}_message"][:text])
    end
  end
  
  def build_empty_texts()
    ProvidersExtra::PROVIDERS.each do |provider|
      self.send("build_#{provider}_message")
    end
  end
  
end
