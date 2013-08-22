module MutationsExtra
  
  class CreateFacebookMessage < Mutations::Command
    required do
      model :message
      string :text
    end
    
    def execute
      # зачем тут лишние присваивания?
      FacebookMessage.create!(inputs)
    end
    
  end
  
  # они же все одинаковые, получится что-то с этим сделать?
  class CreateLinkedinMessage < Mutations::Command
    required do
      model :message
      string :text
    end
    
    def execute
      LinkedinMessage.create!(inputs)
    end
    
  end
  class CreateTumblrMessage < Mutations::Command
    required do
      model :message
      string :text
    end
    
    def execute
      TumblrMessage.create!(inputs)
    end
    
  end
  class CreateTwitterMessage < Mutations::Command
    required do
      model :message
      string :text
    end
    
    def execute
      TwitterMessage.create!(inputs)
    end
    
  end
  class CreateVkontakteMessage < Mutations::Command
    required do
      model :message
      string :text
    end
    
    def execute
      VkontakteMessage.create!(inputs)
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
