# как модель попала в контроллер? надо ее убирать, пока не поздно

class CreateAuthorisation < Mutations::Command
  
  required do
    model :user
    string :provider
    string :uid
    string :token
    string :secret
  end
  
  def execute
    Authorisation.create!(inputs)
  end
end
