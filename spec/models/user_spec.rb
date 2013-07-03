
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
  
  it 'has ability to custom id' do
    user = FactoryGirl.create(:user)
    puts user.id
    user.should be_valid
  end

end
