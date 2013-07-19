
class TwitterMessage < Message
  validates :text, length: { maximum: 140 }
end
