require 'spec_helper'

describe SessionsController, :type => :controller do
  
  describe "#new" do
    it 'should be main page' do
      get :new
      response.should render_template :new

      #~ TODO: its for 'view' tests
      #~ expect(response.body).to include "signin with twitter"
      #~ expect(response.body).to include "facebook"
      #~ expect(response.body).to include "vkontakte"
      #~ expect(response.body).to include "linkedin"
    end
  end
  
  describe "#create" do
    
    # TODO: another providers beside twitter
    describe 'user ne signed in' do
      it 'authorise she' do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
        post :create, :provider => "twitter"
        expect(response.body).to include "Welcome "
      end
    end
    
    describe 'user is signed in' do
      
      it 'should authorise' do
        session[:user_id] = 100
        user = FactoryGirl.create(:user)
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
        post :create, :provider => "twitter"
        expect(response.body).to include "You can now login"
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
