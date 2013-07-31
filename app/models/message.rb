
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
  
  def build_texts params
    self.build_facebook_message text: params[:facebook_message][:text] if params[:facebook_message][:text].length > 0
    self.build_linkedin_message text: params[:linkedin_message][:text] if params[:linkedin_message][:text].length > 0
    self.build_tumblr_message text: params[:tumblr_message][:text] if params[:tumblr_message][:text].length > 0
    self.build_twitter_message text: params[:twitter_message][:text] if params[:twitter_message][:text].length > 0
    self.build_vkontakte_message text: params[:vkontakte_message][:text] if params[:vkontakte_message][:text].length > 0
  end
end
