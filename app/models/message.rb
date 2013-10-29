
class Message < ActiveRecord::Base
  
  belongs_to :user
  
  has_one :twitter_message, dependent: :destroy
  has_one :facebook_message, dependent: :destroy
  has_one :linkedin_message, dependent: :destroy
  has_one :tumblr_message, dependent: :destroy
  has_one :twitter_message, dependent: :destroy
  has_one :vkontakte_message, dependent: :destroy
  
  # TODO: эту проврку в mutations ?
  validates :user_id, presence: true
  
  default_scope -> { order('created_at DESC') }
  
  def build_texts(params)
    ProvidersExtra::PROVIDERS.each do |provider|
      text_to_send = params[:"#{provider}_message"][:text]
      next if text_to_send.length == 0
      text_to_send = sub_br(text_to_send, provider)
      self.send(:"build_#{provider}_message", text: text_to_send)
    end
  end
  
  def sub_br(text_to_send, provider)
    br_dislike = ['twitter', 'linkedin', 'facebook']
    text_to_send = text_to_send.sub("<br>", "") if br_dislike.include? provider
    text_to_send
  end
  
  def build_empty_texts()
    ProvidersExtra::PROVIDERS.each do |provider|
      self.send("build_#{provider}_message")
    end
  end
  
end
