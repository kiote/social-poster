require 'spec_helper'

describe ContactController, :type => :controller do
  
  describe "#new" do
    it "should be page for new message" do
      get :new
      response.should render_template :new
    end
  end
  
  describe "#create" do
    it "should send new message to given provider" do
    end
  end

end
