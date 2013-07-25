
class TwitterMessage < ActiveRecord::Base
  belongs_to :message
  validates :text, length: { maximum: 140 }
end
