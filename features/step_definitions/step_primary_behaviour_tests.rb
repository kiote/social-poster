
Given(/^user is on the main page$/) do
  visit root_path
end

When(/^user click sign in$/) do
  click_link "Sign in"
end

Then(/^user view sign_in page$/) do
  expect(page).to have_title("Sign in")
  
  page.should have_xpath("//input[@id='session_email'][@name='session[email]'][@type='text']")
  expect(page).to have_css("input[id='session_password'][name='session[password]'][type='password']")
  expect(page).to have_xpath("//input[@class='btn btn-large btn-primary'][@name='commit'][@type='submit'][@value='Sign in']")
  
end

When(/^user click sign up$/) do
  all(:xpath, '//a[text()="Sign up"]').first.click
end

Then(/^user view sign_up page, whooa!$/) do
  expect(page).to have_title("Sign up")
  
  expect(page).to have_xpath("//input[@id='user_name'][@name='user[name]'][@type='text']")  
  expect(page).to have_xpath("//input[@id='user_email'][@name='user[email]'][@type='text']")  
  expect(page).to have_xpath("//input[@id='user_password'][@name='user[password]'][@type='password']")
  
  page.should have_css("input[id='user_password_confirmation'][name='user[password_confirmation]'][type='password']")
  expect(page).to have_css("input[class='btn btn-large btn-primary'][name='commit'][type='submit'][value='Create my account']")
end

Given(/^user is on the sign in page$/) do
  visit signin_path
  user = FactoryGirl.create(:user, name: "Savva", email: 'sample@email.ru', password: 'qqqwww')
  v = expect(page).to have_title("Sign in")
  Rails.logger.debug "> %s" % v
end

When(/^fields Email, Password correctly filled and sign in pressed$/) do
  
  fill_in "Email", with: 'sample@email.ru'
  fill_in "Password", with: 'qqqwww'
  field_labeled('Email').value.should =~ /sample@email.ru/
  field_labeled('Password').value.should =~ /qqqwww/
  
end

Then(/^user can observe users\#show page$/) do
  
  vv = find(:xpath, "//input[@class='btn btn-large btn-primary']").click
  
  Rails.logger.debug "> %s" % User.first.name
  Rails.logger.debug "> %s" % User.first.email
  v = expect(page).to have_title("Savva")
  Rails.logger.debug "> title is: %s" % v
  Rails.logger.debug "> link result is: %s" % vv
  expect(page).to have_title("Savva")
  
end

When(/^fields Email, Password incorrectly filled and sign in pressed$/) do
  find(:xpath, "//input[@class='btn btn-large btn-primary']").click
end

Then(/^user can observe sign_in page$/) do
  expect(page).to have_title("Sign in")
end

Then(/^error message$/) do
  expect(page).to have_selector('div.alert.alert-error')
end

Given(/^user is on the sign up page$/) do
  visit signup_path
end

When(/^Name, Email, Password, Confirmation fields correctly filled$/) do
  
  fill_in "Email", with: 'sample@email.ru'
  fill_in "Name", with: 'W'
  fill_in "Password", with: 'qqqwww'
  fill_in "Confirmation", with: 'qqqwww'
  
  field_labeled('Email').value.should == 'sample@email.ru'
  field_labeled('Name').value.should =~ /W/
  field_labeled('Password').value.should == 'qqqwww'
  field_labeled('Confirmation').value.should =~ /qqqwww/
  
end

When(/^button Create Account has been pressed$/) do
  click_button "Create my account"
end

Then(/^there new user appears$/) do
  
  u = User.first
  u.name == "W"
  u.email == "sample@email.ru"
  u.password == "qqqwww"
  u.password_confirmation == "qqqwww"
  
end

Then(/^his page with show action can be observed$/) do
  visit root_path
  click_link "view profile"
end

When(/^any of field is filled incorrectly$/) do
  find(:xpath, "//input[@class='btn btn-large btn-primary']").click
end

Then(/^user can observe sign_up page again$/) do
  expect(page).to have_title("Sign up")
end

Then(/^a message containing error description$/) do
  expect(page).to have_xpath("//input[@id='user_name'][@name='user[name]'][@type='text']")
end

Given(/^user is on the Home page$/) do
  visit root_path
end

#~ Given(/^signed in$/) do
  #~ visit root_path
  #~ user = FactoryGirl.create(:user, name: "Savva", email: 'sample@email.ru', password: 'qqqwww')
  #~ click_link "Sign in"
  #~ fill_in "Email", with: 'sample@email.ru'
  #~ fill_in "Password", with: 'qqqwww'
  #~ find(:xpath, "//input[@class='btn btn-large btn-primary']").click
  #~ click_link "Home"
#~ 
#~ end

Then(/^page contains form_for @message$/) do
  expect(page).to have_xpath("//form[@action='/messages']")
end

Given(/^unsigned$/) do
  expect(page).to have_xpath("//input[@class='btn btn-large btn-primary'][@href='/signup']")
end

Then(/^page contains things for welcome$/) do
  expect(page).to have_title("Home")
  expect(page).to have_content('_ability_to_send_messages_through_networks_')
end



Given(/^user$/) do
  user = FactoryGirl.create(:user, name: "Savva", email: 'sample@email.ru', password: 'qqqwww')
end

Given(/^user is signed in$/) do
  
  visit root_path
  click_link "Sign in"
  fill_in "Email", with: 'sample@email.ru'
  fill_in "Password", with: 'qqqwww'
  find(:xpath, "//input[@class='btn btn-large btn-primary']").click
  expect(page).to have_title("Savva")
  
end

Given(/^user isnt signed$/) do
end

Given(/^there is Home page$/) do
  visit root_path
end

Then(/^there is users profile page \(users show action\)$/) do
  click_link "Profile"
end

Then(/^there is users providers page \(providers show action\)$/) do
  visit root_path
  click_link "view providers"
end

Given(/^clicked to the settings$/) do
  click_link "Settings"
end

Then(/^there is page for settings$/) do
  expect(page).to have_title("Edit user")
end

Given(/^clicked "(.*?)"$/) do |arg1|
  find(:xpath, "//a[text()='#{arg1}']").click
end
