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
		
		puts user.authorisations.length
	end

end
