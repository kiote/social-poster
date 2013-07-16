# encoding: utf-8

#~ человек заходит на страницу вписки
Given(/^user is on the signin page$/) do
  visit signin_path
end

#~ человек вводит не корректную информацию
When(/^user's input is incorrect$/) do
  click_button "Sign in"
end

#~ надо показать ошибку
Then(/^show that its error$/) do
  expect(page).to have_selector('div.alert.alert-error')
end

#~ человек на странице для вписки
Given(/^user is on the signin' page$/) do
  visit signin_path
end

#~ при этом у человека существует авторизация
Given(/^there's account already$/) do
  @user = User.create(name: "Савва", email: "vcabba@yahoo.com", password: "qqqwww", password_confirmation: "qqqwww")
end

#~ подтверждает корректную входную информацию
When(/^user submit email & password$/) do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

#~ видит свою страницу
Then(/^user's page is visible$/u) do
  expect(page).to have_title(@user.name)
end

#~ может видеть указатель к выходу
Then(/^it's avaliable to click signout$/u) do
  expect(page).to have_link('Sign out', href: signout_path)
end
