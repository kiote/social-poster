
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
  
  it 'can self authorise' do
    
    user = FactoryGirl.create(:user)
    
    auth_hash = Hash.new
    
    auth_hash[:provider] = 'vk'
    auth_hash[:uid] = '31'
    auth_hash[:token] = 'aq1'
    auth_hash[:secret] = 'sw2'
    auth_hash['name'] = 'name'
    auth_hash['email'] = 'email'
    
    user.add_authorisation(auth_hash)
    
    user.authorisations.length.should == 1
    
  end
  
  it 'can update name, email, tokens' do
    
    
    user = FactoryGirl.create(:user)
    
    auth_hash = Hash.new
    
    auth_hash[:provider] = 'vk'
    auth_hash[:uid] = '31'
    auth_hash[:token] = 'aq1'
    auth_hash[:secret] = 'sw2'
    auth_hash['name'] = 'name'
    auth_hash['email'] = 'email'
    
    user.add_authorisation(auth_hash)
    
    auth_hash[:token] = 'aq1c'
    auth_hash[:secret] = 'sw2c'
    auth_hash['name'] = 'namec'
    auth_hash['email'] = 'emailc'
    
    user.update_info(auth_hash)
    
    user.name.should == 'namec'
    user.email.should == 'emailc'
    
    auth = user.authorisations.first
    auth.token.should == 'aq1c'
    auth.secret.should == 'sw2c'
    
  end

end
