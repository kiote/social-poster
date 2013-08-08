
include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
    remember_me = User.new_remember_token
    cookies[:remember_me] = remember_me
    user.update_attribute(:remember_me, User.encrypt(remember_me))
  else
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end
    
