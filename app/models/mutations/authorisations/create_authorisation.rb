
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
    if user.authorisations.find_by_provider(provider)
      user.authorisations.find_by_provider(provider)
    else
      Authorisation.create!(inputs)
    end
  end
end
