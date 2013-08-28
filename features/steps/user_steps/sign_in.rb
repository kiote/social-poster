
module UserSteps
  module SignIn
    
    include Spinach::DSL
    
    step 'user is signed in' do
      visit signin_path
      fill_in "Email", with: 'vcabba@gmx.com'
      fill_in "Password", with: 'qqqwww'
      find(:xpath, "//input[@class='btn btn-large btn-primary'][@value='Sign in']").click
      expect(page).to have_title("Savva")
    end
    
    step 'user' do
      @user = FactoryGirl.create(:user, name: "Savva", email: 'vcabba@gmx.com', password: 'qqqwww')
    end
    
  end
end
