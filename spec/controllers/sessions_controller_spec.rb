require 'spec_helper'

describe SessionsController, :type => :controller do
  
  describe "#new" do
    it 'should be main page' do
      get :new
      response.should render_template :new
    end
  end
  
  describe "#create" do
    
    providers = { twitter: "twitter", facebook: "facebook", vkontakte: "vkontakte", linkedin: "linkedin" }
      
    describe 'user not signed in' do
      
      #~ session[:user_id] = nil
      
      describe 'already exist authorisations for user' do
      
        providers.each do |provider_sym, provider_str|
        
          it "sign in she on #{provider_str}" do
            
            request.env['omniauth.auth'] = OmniAuth.config.mock_auth[provider_sym]
            auth_hash = {'name' => 'name', 'email' => 'email',
              provider: provider_str,
              uid: '13', token: 'token', secret: 'secret'
            }
            auth = Authorisation.build_it_with_user(auth_hash)
            
            post :create, :provider => provider_str
            
            response.should redirect_to "/contact/#{provider_str}"
            
          end
          
        end
        
      end
      
      describe 'build new authorisations for user' do
      
        providers.each do |provider_sym, provider_str|
        
          it "sign in she on #{provider_str}" do
            
            request.env['omniauth.auth'] = OmniAuth.config.mock_auth[provider_sym]
            
            #~ auth = Authorisation.build_it_with_user(auth_hash)
            #~ they could be created from within controller
            
            post :create, provider: provider_str
            
            response.should redirect_to "/contact/#{provider_str}"
            
          end
        end
        
      end
      
    end
    
    describe 'user signed in' do
      
      before :each do
        get "new"
        session[:user_id] = 13
      end
      
      
      providers.each do |provider_sym, provider_str|
        it "should authorise on #{provider_str}" do
        
          user = FactoryGirl.create(:user)
          request.env['omniauth.auth'] = OmniAuth.config.mock_auth[provider_sym]
          post :create, :provider => provider_str
          
          response.should redirect_to "/contact/#{provider_str}"
          
        end
      end
    end
    
  end
  
  describe "#destroy" do
    it 'should signout' do
      post :destroy
      session[:user_id].should == nil
    end
  end
  
  describe "#failure" do
    it 'shouldnt be' do
      get :failure
      response.should render_template :failure
    end
  end
  
end
