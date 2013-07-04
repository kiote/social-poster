
require "spec_helper"

describe "sessions/new.html.haml" do
	it "displays welcome page" do
		render
		rendered.should include("twitter")
		rendered.should include("facebook")
		rendered.should include("vkontakte")
		rendered.should include("linkedin")
	end
end
