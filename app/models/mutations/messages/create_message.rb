

module SubBrs
  def sub_brs text
    text.gsub!("<br>", "")
  end
end

class CreateMessage < Mutations::Command
  
  required do
    model :user
  end
  
  optional do

    hash :linkedin_message do
      string :*, :discard_empty => true
    end
  
    hash :twitter_message do
      string :*, :discard_empty => true
    end
    
    hash :tumblr_message do
      string :*, :discard_empty => true
    end
  
    hash :vkontakte_message do
      string :*, :discard_empty => true
    end
  
    hash :facebook_message do
      string :*, :discard_empty => true
    end
    
  end
  
  def execute
    
    message = Message.create!(user: user)
    message.sent_at = Time.new
    
    LinkedinMessage.create!(message: message, text: inputs[:linkedin_message][:text]) if inputs[:linkedin_message][:text]
    FacebookMessage.create!(message: message, text: inputs[:facebook_message][:text]) if inputs[:facebook_message][:text]
    TwitterMessage.create!(message: message, text: inputs[:twitter_message][:text]) if inputs[:twitter_message][:text].length < 513
    TumblrMessage.create!(message: message, text: inputs[:tumblr_message][:text]) if inputs[:tumblr_message][:text]
    VkontakteMessage.create!(message: message, text: inputs[:vkontakte_message][:text]) if inputs[:vkontakte_message][:text]
    
    message
  end
  
end
