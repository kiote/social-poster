
Given(/^there is a message to Linkedin$/) do
  fill_in "linkedin_message_text", with: "Message for Linkedin %s" % Time.now
end

Given(/^user is authorised for linkedin$/) do
  user = User.first
  FactoryGirl.create(:auth_linkedin, user: user)
  user.authorisations.first.provider.should == 'linkedin'
end

When(/^user click to post a message$/) do
  VCR.use_cassette("I hope its something with external calls", record: :new_episodes) do
    find(:xpath, "//input[@class='btn btn-large btn-primary'][@value='Post']").click
  end
end

Then(/^sent to facebook okay$/) do
  expect(page).to have_xpath("//div[@class='alert alert-success']")
  expect(page).to have_content("sent to facebook okay")
end

Then(/^sent to linkedin okay$/) do
  expect(page).to have_xpath("//div[@class='alert alert-success']")
  expect(page).to have_content("sent to linkedin okay")
end

Then(/^successfully sent to tumblr$/) do
  expect(page).to have_xpath("//div[@class='alert alert-success']")
  expect(page).to have_content("tumblr: created")
end

Then(/^sent to twitter okay$/) do
  expect(page).to have_xpath("//div[@class='alert alert-success']")
  expect(page).to have_content("sent to twitter okay")
end

Then(/^sent to vkontakte okay$/) do
  expect(page).to have_xpath("//div[@class='alert alert-success']")
  expect(page).to have_content("sent to vkontakte okay")
end

Given(/^user is authorised for facebook$/) do
  user = User.first
  FactoryGirl.create(:auth_facebook, user: user)
  user.authorisations.first.provider.should == 'facebook'
end

Given(/^there is a message to Facebook$/) do
  fill_in "facebook_message_text", with: "Message for Facebook %s" % Time.now
end

Given(/^user is authorised for Tumblr$/) do
  user = User.first
  FactoryGirl.create(:auth_tumblr, user: user)
  user.authorisations.first.provider.should == 'tumblr'
end

Given(/^there is a message to Tumblr$/) do
  fill_in "tumblr_message_text", with: "Message for Tumblr %s" % Time.now
end

Given(/^user is authorised for Twitter$/) do
  user = User.first
  FactoryGirl.create(:auth_twitter, user: user)
  user.authorisations.first.provider.should == 'twitter'
end

Given(/^there is a message to Twitter$/) do
  fill_in "twitter_message_text", with: "Message for Twitter %s" % Time.now
end

Given(/^user is authorised for vkontakte$/) do
  user = User.first
  FactoryGirl.create(:auth_vkontakte, user: user)
  user.authorisations.first.provider.should == 'vkontakte'
end

Given(/^there is a message to Vkontakte$/) do
  fill_in "vkontakte_message_text", with: "Message for Vkontakte %s" % Time.now
end
