require 'spec_helper'

describe SessionsController, :type => :controller do
  
  describe "#new" do
    it 'should be main page' do
      get :new
      response.should render_template :new
    end
  end
  
  describe "#create" do
    
    describe 'user ne signed in' do
       { "twitter" => :twitter, "facebook" => :facebook, "vkontakte" => :vkontakte, "linkedin" => :linkedin }.each do |provider_str, provider_sym|
        it "authorise she on #{provider_str}" do
          request.env['omniauth.auth'] = OmniAuth.config.mock_auth[provider_sym]
          post :create, :provider => provider_str
          expect(response.body).to include "Welcome "
        end
      end
    end
    
    describe 'user is signed in' do
      { "twitter" => :twitter, "facebook" => :facebook, "vkontakte" => :vkontakte, "linkedin" => :linkedin }.each do |provider_str, provider_sym|
        it "should authorise on #{provider_str}" do
          session[:user_id] = 100
          user = FactoryGirl.create(:user)
          request.env['omniauth.auth'] = OmniAuth.config.mock_auth[provider_sym]
          post :create, :provider => provider_str
          expect(response.body).to include "You can now login"
        end
      end
    end
    
  end
  
  describe "#destroy" do
    it 'should signout' do
      post :destroy
      session[:user_id].should == nil
      response.should render_template :destroy
    end
  end
  
  describe "#failure" do
    it 'shouldnt be' do
      get :failure
      response.should render_template :failure
    end
  end
  
end
