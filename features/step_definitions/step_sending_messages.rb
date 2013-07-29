
Given(/^user is signed in and authorised on twitter$/) do
  @user = User.create(name: "Савва", email: "vcabba@yahoo.com", password: "qqqwww", password_confirmation: "qqqwww")
  visit signin_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
  expect(page).to have_content("Twitter")
  visit root_path
  expect(page).to have_title("Home")
  
end

Given(/^there is root page$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^user's input is correct$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^show that messages is sent to twitter$/) do
  pending # express the regexp above with the code you wish you had
end
