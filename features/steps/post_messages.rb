class Spinach::Features::PostMessages < Spinach::FeatureSteps
  
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

  step 'user is authorised for facebook' do
    user = User.first
    FactoryGirl.create(:auth_facebook, user: user)
    user.authorisations.first.provider.should == 'facebook'
  end

  step 'there is Home page' do
    visit root_path
  end

  step 'there is a message to Facebook' do
    fill_in "facebook_message_text", with: "Message for Facebook %s" % Time.now
  end

  step 'user click to post a message' do
    VCR.use_cassette("I hope its something with external calls", record: :new_episodes) do
      find(:xpath, "//input[@class='btn btn-large btn-primary'][@value='Post']").click
    end
  end

  step 'sent to facebook okay' do
    expect(page).to have_xpath("//div[@class='alert alert-success']")
    expect(page).to have_content("facebook: created")
  end

  step 'user is authorised for linkedin' do
    user = User.first
    FactoryGirl.create(:auth_linkedin, user: user)
    user.authorisations.first.provider.should == 'linkedin'
  end

  step 'there is a message to Linkedin' do
    fill_in "linkedin_message_text", with: "Message for Linkedin %s" % Time.now
  end

  step 'sent to linkedin okay' do
    expect(page).to have_xpath("//div[@class='alert alert-success']")
    expect(page).to have_content("linkedin: created")
  end

  step 'user is authorised for Tumblr' do
    user = User.first
    FactoryGirl.create(:auth_tumblr, user: user)
    user.authorisations.first.provider.should == 'tumblr'
  end

  step 'there is a message to Tumblr' do
    fill_in "tumblr_message_text", with: "Message for Tumblr %s" % Time.now
  end

  step 'successfully sent to tumblr' do
    expect(page).to have_xpath("//div[@class='alert alert-success']")
    expect(page).to have_content("tumblr: created")
  end

  step 'user is authorised for Twitter' do
    user = User.first
    FactoryGirl.create(:auth_twitter, user: user)
    user.authorisations.first.provider.should == 'twitter'
  end

  step 'there is a message to Twitter' do
    fill_in "twitter_message_text", with: "Message for Twitter %s" % Time.now
  end

  step 'sent to twitter okay' do
    expect(page).to have_xpath("//div[@class='alert alert-success']")
    expect(page).to have_content("twitter: created")
  end

  step 'user is authorised for vkontakte' do
    user = User.first
    FactoryGirl.create(:auth_vkontakte, user: user)
    user.authorisations.first.provider.should == 'vkontakte'
  end

  step 'there is a message to Vkontakte' do
    fill_in "vkontakte_message_text", with: "Message for Vkontakte %s" % Time.now
  end

  step 'sent to vkontakte okay' do
    expect(page).to have_xpath("//div[@class='alert alert-success']")
    expect(page).to have_content("vkontakte: created")
  end
end
