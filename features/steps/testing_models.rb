
class Spinach::Features::TestingModels < Spinach::FeatureSteps
  
  #~ include UserSteps::SignIn
  
  step 'user' do
   @user = FactoryGirl.create(:user, name: "Savva", email: 'vcabba@gmx.com', password: 'qqqwww')
  end
  
  step 'there attempt to create a message for user' do
    @outcome = CreateMessage.run(user: @user)
  end
  
  step 'message is created' do
    @outcome.success?.should == true
    @message = @outcome.result
  end
  
  step 'there attempt to create a submessages for message' do
    @facebook_message_outcome = CreateFacebookMessage.run(text: "facebook", message: @message)
    @linkedin_message_outcome = CreateLinkedinMessage.run(text: "linkedin", message: @message)
    @tumblr_message_outcome = CreateTumblrMessage.run(text: "tumblr", message: @message)
    @twitter_message_outcome = CreateTwitterMessage.run(text: "twitter", message: @message)
    @vkontakte_message_outcome = CreateVkontakteMessage.run(text: "vkontakte", message: @message)
  end
  
  step 'submessages is created' do
    @facebook_message_outcome.success?.should == true
    @message.facebook_message.text.should == "facebook"
    @message.linkedin_message.text.should == "linkedin"
    @message.tumblr_message.text.should == "tumblr"
    @message.twitter_message.text.should == "twitter"
    @message.vkontakte_message.text.should == "vkontakte"
  end
  
end
