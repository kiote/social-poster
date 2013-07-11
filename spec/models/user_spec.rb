
require 'spec_helper'

describe User do

	it "can be instantiated" do
		User.new.should be_an_instance_of(User)
	end

	it "can be saved successfully" do
		User.create.should be_persisted
	end

	it 'has valid fact' do
		FactoryGirl.build(:user).should be_valid
	end
  
  it 'should be_valid' do
    user = FactoryGirl.create(:user)
    user.should be_valid
  end
  
  it 'should be okay to add provider' do
    user = FactoryGirl.create(:user)
    
    auth_hash = Hash.new
    
    auth_hash[:provider] = 'vk'
    auth_hash[:uid] = '31'
    auth_hash[:token] = 'aq1'
    auth_hash[:secret] = 'sw2'
    
    user.add_provider(auth_hash)
    
    user.authorisations.length.should == 1
    
    
  end

end
