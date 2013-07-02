require 'spec_helper'

describe SessionsController, :type => :controller do
  
  describe "#new" do
    it 'should be' do
      get :new
      response.should be_success
    end
  end
  
  describe "#create" do
    it 'should be' do
      
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
      
      post :create, :provider => "twitter"
      
      #~ expect(response.body).to include "You can now login"
      expect(response.body).to include "Welcome name"
      #~ response.should be_success
    end
  end
  
end
