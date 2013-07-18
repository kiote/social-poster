require 'spec_helper'

describe Authorisation do

  it "can be instantiated" do
    Authorisation.new.should be_an_instance_of(Authorisation)
  end
  
  it "can be saved successfully" do
    Authorisation.create(:uid => '123', :provider => '321').should be_persisted
  end
  
  it 'has valid fact' do
    FactoryGirl.build(:authorisation).should be_valid
  end
  
  it 'authorisation uniqueness should be' do
    user = FactoryGirl.create(:user)
    auth = FactoryGirl.create(:authorisation, user: user, provider: 'linkedin', uid: '13').should be_valid
    auth = FactoryGirl.build(:authorisation, user: user, provider: 'linkedin', uid: '13').should_not be_valid
  end
  
  it 'can be build up' do
    
    user = FactoryGirl.create(:user)
    auth = FactoryGirl.build(:authorisation, user: user, provider: 'linkedin', uid: '13')
    auth.user.name.should == 'Savva'
  end
  
  it 'can be updated' do
    # TODO: email & name из авторизаций как бы не нужны, а если токен поменялся как проверить?
    user = FactoryGirl.create(:user)
    auth = FactoryGirl.build(:authorisation, user: user, provider: 'linkedin', uid: '13')
    auth.save
    auth.user.name = 'Petya'
    auth.save
    auth.user.name.should == 'Petya'
    
  end
  
  
end
