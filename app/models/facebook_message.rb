
class FacebookMessage < ActiveRecord::Base
  belongs_to :message
  validates :text, length: { maximum: 512 }
end
