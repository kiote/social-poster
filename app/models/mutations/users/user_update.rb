class UserUpdate < Mutations::Command
  
  required do
    model :user
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    string :name
    string :email, matches: VALID_EMAIL_REGEX
    string :password, min_length: 5
    string :password_confirmation
    
  end
  
  def execute
    
    if password != password_confirmation
      add_error(:password_confirmation, :doesnt_match, "Your passwords don't match.")
      return
    end
    
    if User.find_by_email(email) and user.email != email
      add_error(:email, :doesnt_unique, "Your email already taken.")
      return
    end
    
    user.name = name
    user.email = email
    user.password = password
    user
  end
  
end
