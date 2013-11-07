
When(/^create new user$/) do
  
  params = {
    "name"=>"Savva",
    "email"=>"savva@mail.ru",
    "password"=>"qqqwww",
    "password_confirmation"=>"qqqwww"
    }
    
  outcome = UserCreate.run(params)
  
  if not outcome.success?
    raise outcome.inspect
  end
  
end

Then(/^saved$/) do
  if not User.find_by_email('savva@mail.ru')
    raise 'there is no such user'
  end
end

Then(/^update info/) do
  params = {
    "name"=>"Cabba",
    "email"=>"cabba@mail.ru",
    "password"=>"wwwqqq",
    "password_confirmation"=>"wwwqqq"
    }
    
  outcome = UserUpdate.run(params, user: User.find_by_email('savva@mail.ru'))
  
  if not outcome.success?
    raise outcome.inspect
  end
  
  outcome.result.name.should eq 'Cabba'
  outcome.result.email.should eq 'cabba@mail.ru'
end

Then(/^not update incorrect info/) do
  params = {
    "name"=>"Cabba",
    "email"=>"cabbamailru",
    "password"=>"wwqq",
    "password_confirmation"=>"wwwwww"
    }
    
  outcome = UserUpdate.run(params, user: User.find_by_email('cabba@mail.ru'))
  
  # raise outcome.errors.inspect
  # outcome.errors.symbolic["password_confirmation"].should eq :doesnt_match
  outcome.errors.symbolic["email"].should eq :matches
  outcome.errors.symbolic["password"].should eq :min_length
  
  User.find_by_email('cabba@mail.ru').name.should eq 'Cabba'
  User.find_by_email('cabba@mail.ru').email.should eq 'cabba@mail.ru'
end
