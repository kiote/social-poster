class Spinach::Features::TestingUsersBehaviour < Spinach::FeatureSteps
  step 'user is on the main page' do
    visit root_path
  end

  step 'user click sign in' do
    click_link "Sign in"
  end

  step 'user view sign_in page' do
    expect(page).to have_title("Sign in")
  
    page.should have_xpath("//input[@id='session_email'][@name='session[email]'][@type='text']")
    expect(page).to have_css("input[id='session_password'][name='session[password]'][type='password']")
    expect(page).to have_xpath("//input[@class='btn btn-large btn-primary'][@name='commit'][@type='submit'][@value='Sign in']")
  end

  step 'user click sign up' do
    all(:xpath, '//a[text()="Sign up"]').first.click
  end

  step 'user view sign_up page, whooa!' do
    expect(page).to have_title("Sign up")
    
    expect(page).to have_xpath("//input[@id='user_name'][@name='user[name]'][@type='text']")  
    expect(page).to have_xpath("//input[@id='user_email'][@name='user[email]'][@type='text']")  
    expect(page).to have_xpath("//input[@id='user_password'][@name='user[password]'][@type='password']")
    
    page.should have_css("input[id='user_password_confirmation'][name='user[password_confirmation]'][type='password']")
    expect(page).to have_css("input[class='btn btn-large btn-primary'][name='commit'][type='submit'][value='Create my account']")
  end

  step 'user is on the sign in page' do
    visit signin_path
    user = FactoryGirl.create(:user, name: "Savva", email: 'sample@email.ru', password: 'qqqwww')
    v = expect(page).to have_title("Sign in")
  end

  step 'fields Email, Password correctly filled and sign in pressed' do
    fill_in "Email", with: 'sample@email.ru'
    fill_in "Password", with: 'qqqwww'
    field_labeled('Email').value.should =~ /sample@email.ru/
    field_labeled('Password').value.should =~ /qqqwww/
  end

  step 'user can observe users' do
    vv = find(:xpath, "//input[@class='btn btn-large btn-primary']").click
    v = expect(page).to have_title("Savva")
    expect(page).to have_title("Savva")
  end

  step 'fields Email, Password incorrectly filled and sign in pressed' do
    find(:xpath, "//input[@class='btn btn-large btn-primary']").click
  end

  step 'user can observe sign_in page' do
    expect(page).to have_title("Sign in")
  end

  step 'error message' do
    expect(page).to have_selector('div.alert.alert-error')
  end

  step 'user is on the sign up page' do
    visit signup_path
  end

  step 'Name, Email, Password, Confirmation fields correctly filled' do
    fill_in "Email", with: 'sample@email.ru'
    fill_in "Name", with: 'W'
    fill_in "Password", with: 'qqqwww'
    fill_in "Confirmation", with: 'qqqwww'
    
    field_labeled('Email').value.should == 'sample@email.ru'
    field_labeled('Name').value.should =~ /W/
    field_labeled('Password').value.should == 'qqqwww'
    field_labeled('Confirmation').value.should =~ /qqqwww/
  end

  step 'button Create Account has been pressed' do
    click_button "Create my account"
  end

  step 'there new user appears' do
    u = User.first
    u.name == "W"
    u.email == "sample@email.ru"
    u.password == "qqqwww"
    u.password_confirmation == "qqqwww"
  end

  step 'his page with show action can be observed' do
    visit root_path
    click_link "view profile"
  end

  step 'any of field is filled incorrectly' do
    fill_in "Email", with: 'vcabba@gmx.com'
    fill_in "Name", with: 'vcabba'
    fill_in "Password", with: 'qqqwww'
    fill_in "Confirmation", with: 'qqqwww'
    find(:xpath, "//input[@class='btn btn-large btn-primary']").click
  end

  step 'user can observe sign_up page again' do
    expect(page).to have_title("Sign up")
  end

  step 'a message containing error description' do
    expect(page).to have_xpath("//input[@id='user_name'][@name='user[name]'][@type='text']")
  end

  step 'user' do
    user = FactoryGirl.create(:user, name: "Savva", email: 'vcabba@gmx.com', password: 'qqqwww')
  end

  step 'user is signed in' do
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: 'vcabba@gmx.com'
    fill_in "Password", with: 'qqqwww'
    find(:xpath, "//input[@class='btn btn-large btn-primary']").click
    expect(page).to have_title("Savva")
  end

  step 'there is Home page' do
    visit root_path
  end

  step 'page contains form_for @message' do
    expect(page).to have_xpath("//form[@action='/messages']")
  end

  step 'user isnt signed' do
  end

  step 'page contains things for welcome' do
    expect(page).to have_title("Home")
    expect(page).to have_content('_ability_to_send_messages_through_networks_')
  end

  step 'clicked "view profile"' do
    find(:xpath, "//a[text()='view profile']").click
  end

  step 'there is users profile page (users show action)' do
    click_link "Profile"
  end

  step 'clicked "view providers"' do
    find(:xpath, "//a[text()='view providers']").click
  end

  step 'there is users providers page (providers show action)' do
    visit root_path
    click_link "view providers"
  end

  step 'clicked to the settings' do
    click_link "Settings"
  end

  step 'there is page for settings' do
    expect(page).to have_title("Edit user")
  end
end
