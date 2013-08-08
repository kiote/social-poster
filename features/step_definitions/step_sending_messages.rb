
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

Then(/^there is a message that message is sent okay$/) do
  expect(page).to have_xpath("//div[@class='alert alert-success']")
  expect(page).to have_content("sent to linkedin okay")
end
