
class TumblrMessage < ActiveRecord::Base
  belongs_to :message
  validates :text, length: { maximum: 512 }
end
