require 'spec_helper'

describe User do

	it "has a valid factory" do
		FactoryGirl.create(:user).should be_valid
	end

	it "is invalid without name" do
		FactoryGirl.build(:user, name: nil).should_not be_valid
	end

	it "returns name and email as a string" do
		user = FactoryGirl.build(:user, name: "John", email: "john@email.com")
		user.name.should == "John"
		user.email.should == "john@email.com"
	end

end
