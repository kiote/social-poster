# encoding=utf-8 

Given(/^человек заходит на страницу вписки$/) do
  visit signin_path
end

When(/^человек вводит не корректную информацию$/) do
  click_button "Sign in"
end

Then(/^надо показать ошибку$/) do
  expect(page).to have_selector('div.alert.alert-error')
end

Given(/^человек на странице для вписки$/) do
  visit signin_path
end

Given(/^при этом у человека существует авторизация$/) do
  @user = User.create(name: "Савва", email: "vcabba@yahoo.com", password: "qqqwww", password_confirmation: "qqqwww")
end

When(/^подтверждает корректную входную информацию$/) do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Then(/^видит свою страницу$/) do
  expect(page).to have_title(@user.name)
end

Then(/^может видеть указатель к выходу$/) do
  expect(page).to have_link('Sign out', href: signout_path)
end
