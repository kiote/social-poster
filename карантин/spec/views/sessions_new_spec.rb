
require "spec_helper"

describe "sessions/new.html.haml" do
	it "displays welcome page" do
		render
		rendered.should include("Sign in")
	end
end
