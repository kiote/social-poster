
class Message < ActiveRecord::Base
  
  belongs_to :user
  
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :text, presence: true
  
  def to_partial_path
    'messages/message'
  end
  
end
