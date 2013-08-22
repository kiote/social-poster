
module MutationsExtra
  
  class CreateFacebookMessage < Mutations::Command
    required do
      model :message
      string :text
    end
    
    def execute
      facebook_message = FacebookMessage.create!(inputs)
      facebook_message
    end
    
  end
  
  class CreateLinkedinMessage < Mutations::Command
    required do
      model :message
      string :text
    end
    
    def execute
      linkedin_message = LinkedinMessage.create!(inputs)
      linkedin_message
    end
    
  end
  class CreateTumblrMessage < Mutations::Command
    required do
      model :message
      string :text
    end
    
    def execute
      tumblr_message = TumblrMessage.create!(inputs)
      tumblr_message
    end
    
  end
  class CreateTwitterMessage < Mutations::Command
    required do
      model :message
      string :text
    end
    
    def execute
      twitter_message = TwitterMessage.create!(inputs)
      twitter_message
    end
    
  end
  class CreateVkontakteMessage < Mutations::Command
    required do
      model :message
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
  
  class Star
    def initialize
    end
  end
  
  ABS = 123
  
end
