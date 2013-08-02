
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
  click_button "Sign up"
end

Then(/^user view sign_up page, whooa!$/) do
  expect(page).to have_title("Sign up")
  
  expect(page).to have_selector("input", id: 'user_name', name: 'user[name]', type: "text")
  expect(page).to have_selector("input", id: 'user_email', name: 'user[email]', type: "text")
  expect(page).to have_selector("input", id: 'user_password', name: 'user[password]', type: "password")
  expect(page).to have_selector("input", id: 'user_password_confirmation', name: 'user[password_confirmation]', type: "password")
  expect(page).to have_selector("input", class: 'btn btn-large btn-primary', name: 'commit', type: "submit", value: 'Create my account')
end

Given(/^user is on the sign in page$/) do
  visit sign_in_path
end

When(/^fields Email, Password correctly filled$/) do
  fill_in "Email", with: 'sample@email.ru'
  fill_in "Password", with: 'qqqwww'
  field_labeled('Email').value.should =~ 'sample@email.ru'
  field_labeled('Password').value.should =~ 'qqqwww'
end

When(/^button Sign In has been pressed$/) do
  click_button "Sign in"
end

Then(/^user can observe users\#show page$/) do
  User.create(name: "Савва", email: "vcabba@yahoo.com", password: "qqqwww", password_confirmation: "qqqwww")
  visit "users#show/1"
  expect(page).to have_title("Савва")
end

When(/^fields Email, Password incorrectly filled$/) do
  fill_in "Email", with: 'sample@email.ru'
  fill_in "Password", with: 'qqqww'
  field_labeled('Email').value.should =~ 'sample@email.ru'
  field_labeled('Password').value.should =~ 'qqqwww'
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

When(/^ Name, Email, Password, Confirmation fields correctly filled$/) do
  
  fill_in "Email", with: 'sample@email.ru'
  fill_in "Name", with: 'W'
  fill_in "Password", with: 'qqqwww'
  fill_in "Confirmation", with: 'qqqwww'
  
  field_labeled('Email').value.should =~ 'sample@email.ru'
  field_labeled('Name').value.should =~ 'W'
  field_labeled('Password').value.should =~ 'qqqwww'
  field_labeled('Confirmation').value.should =~ 'qqqwww'
  
end

When(/^button Create Account has been pressed$/) do
  click_button "Create My Account"
end

Then(/^there new user appears$/) do
  
  u = User.first
  u.name == "W"
  u.email == "sample@email.ru"
  u.password == "qqqwww"
  u.password_confirmation == "qqqwww"
  
end

Then(/^his page with show action can be observed$/) do
  visit "users#show/1"
end

When(/^any of field is filled incorrectly$/) do
  fill_in "Email", with: 'sample@email.ru'
  fill_in "Name", with: 'W'
  fill_in "Password", with: 'qqqwww'
  fill_in "Confirmation", with: 'qqqwww'
  
  field_labeled('Email').value.should =~ 'same@email.ru'
  field_labeled('Name').value.should =~ 'W'
  field_labeled('Password').value.should =~ 'qqqwww'
  field_labeled('Confirmation').value.should =~ 'qqqwww'
end

Then(/^user can observe sign_up page again$/) do
  expect(page).to have_title("Sign up")
end

Then(/^a message containing error description$/) do
  expect(page).to have_selector('div.alert.alert-error')
end
Given(/^user is on the Home page$/) do
  visit root_path
end

Given(/^signed in$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^page contains form_for @message$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^unsigned$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^page contains things for welcome$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^clicked "(.*?)"$/) do |arg1|
  click_button "Create #{arg1} Account"
end

Then(/^it just users\#show\/id action$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^it just some action for TODO:$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^TODO: that is given$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^TODO: ths is to do$/) do
  pending # express the regexp above with the code you wish you had
end


