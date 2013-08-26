
module SubBrs
  def sub_brs text
    text.gsub!("<br>", "")
  end
end

class CreateSubMessage < Mutations::Command
  
  include SubBrs
  
  required do
    model :message
    string :text
  end
  
  def execute
  end
  
end

class CreateFacebookMessage < CreateSubMessage
  
  def execute
    sub_brs(text)
    facebook_message = FacebookMessage.create!(inputs)
    facebook_message
  end
  
end

class CreateLinkedinMessage < CreateSubMessage
  
  def execute
    sub_brs(text)
    linkedin_message = LinkedinMessage.create!(inputs)
    linkedin_message
  end
  
end

class CreateTumblrMessage < CreateSubMessage
  
  def execute
    tumblr_message = TumblrMessage.create!(inputs)
    tumblr_message
  end
  
end

class CreateTwitterMessage < CreateSubMessage
  
  def execute
    sub_brs(text)
    twitter_message = TwitterMessage.create!(inputs)
    twitter_message
  end
  
end

class CreateVkontakteMessage < CreateSubMessage
  
  def execute
    vkontakte_message = VkontakteMessage.create!(inputs)
    vkontakte_message
  end
  
end

class CreateMessage < Mutations::Command
  
  required do
    model :user
  end
  
  def execute
    
    message = Message.create!(inputs)
    message.sent_at = Time.new
    message
  end
  
end
