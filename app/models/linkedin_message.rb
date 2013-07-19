
class LinkedinMessage < Message
  validates :text, length: { maximum: 512 }
end
