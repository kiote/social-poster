
require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "signup" do

		before { visit signup_path }

		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name", with: "Savva"
				fill_in "Email", with: "vcabba@rambler.ru"
				fill_in "Password", with: "qqqwww"
				fill_in "Confirmation", with: "qqqwww"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end

	end
end

