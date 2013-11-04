class Spinach::Features::SigningIn < Spinach::FeatureSteps
  
  #~ TODO : include UserSteps::SignIn
  
  step 'user is on the signin page' do
    visit signin_path
  end
  
  step 'user is signed in' do
    visit signin_path
    fill_in "Email", with: 'vcabba@gmx.com'
    fill_in "Password", with: 'qqqwww'
    find(:xpath, "//input[@class='btn btn-large btn-primary'][@value='Sign in']").click
    expect(page).to have_title("Savva")
  end

  step 'user\'s input is incorrect' do
    
    fill_in "Email", with: 'vcabba@gmx.com'
    fill_in "Password", with: 'wwwqqq'
    
    find(:xpath, "//input[@class='btn btn-large btn-primary']").click
  end

  step 'show that its error' do
    expect(page).to have_selector('div.alert.alert-error')
  end
  
  step 'user have account' do
    @user = FactoryGirl.create(:user, name: "Savva", email: 'vcabba@gmx.com', password: 'qqqwww')
  end

  step 'user submit email & password' do
    fill_in "Email", with: 'vcabba@gmx.com'
    fill_in "Password", with: 'qqqwww'
    
    find(:xpath, "//input[@class='btn btn-large btn-primary']").click
  end

  step 'user\'s page is visible' do
    expect(page).to have_title(@user.name)
  end

  step 'it\'s avaliable to click signout' do
    expect(page).to have_link('Sign out', href: signout_path)
  end
end
