
class Message < ActiveRecord::Base
  
  belongs_to :user
  
  has_one :twitter_message, dependent: :destroy
  has_one :facebook_message, dependent: :destroy
  has_one :linkedin_message, dependent: :destroy
  has_one :vkontakte_message, dependent: :destroy
  has_one :tumblr_message, dependent: :destroy
  
  validates :user_id, presence: true
  default_scope -> { order('created_at DESC') }
  
  def twitter_text
    self.twitter_message.text
  end
  
  def facebook_text
    self.facebook_message.text
  end
  
  def linkedin_text
    self.linkedin_message.text
  end
  
  def vkontakte_text
    self.vkontakte_message.text
  end
  
  def tumblr_text
    self.tumblr_message.text
  end
  
end
