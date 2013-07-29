
class Message < ActiveRecord::Base
  
  belongs_to :user
  
  has_one :twitter_message, dependent: :destroy
  has_one :facebook_message, dependent: :destroy
  has_one :linkedin_message, dependent: :destroy
  has_one :vkontakte_message, dependent: :destroy
  has_one :tumblr_message, dependent: :destroy
  
  validates :user_id, presence: true
  default_scope -> { order('created_at DESC') }
  
end
