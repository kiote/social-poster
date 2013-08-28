
module SubBrs
  def sub_brs text
    text.gsub!("<br>", "")
  end
end

class CreateFacebookMessage < Mutations::Command
  
  include SubBrs
  
  required do
    model :message
  end
  
  optional do
    string :text
  end
  
  def execute
    sub_brs(text) if text
    facebook_message = FacebookMessage.create!(inputs)
    facebook_message
  end
  
end

class CreateLinkedinMessage < Mutations::Command
  
  include SubBrs
  
  required do
    model :message
  end
  
  optional do
    string :text
  end
  
  def execute
    sub_brs(text) if text
    linkedin_message = LinkedinMessage.create!(inputs)
    linkedin_message
  end
  
end

class CreateTumblrMessage < Mutations::Command
  
  include SubBrs
  
  required do
    model :message
  end
  
  optional do
    string :text
  end
    
  def execute
    tumblr_message = TumblrMessage.create!(inputs)
    tumblr_message
  end
  
end

class CreateTwitterMessage < Mutations::Command
  
  include SubBrs
  
  required do
    model :message
  end
  
  optional do
    string :text
  end
    
  def execute
    sub_brs(text) if text
    twitter_message = TwitterMessage.create!(inputs)
    twitter_message
  end
  
end

class CreateVkontakteMessage < Mutations::Command
  
  include SubBrs
  
  required do
    model :message
  end
  
  optional do
    string :text
  end
    
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
