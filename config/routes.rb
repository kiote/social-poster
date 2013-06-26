OmniauthDemo::Application.routes.draw do

  get "/signin" => "services#signin"
  get "/signout" => "services#signout"
  
  get '/auth/:service/callback' => 'services#create' 
  
  get '/auth/failure' => 'services#failure'
  
  get "services/send_facebook"
  get "services/send_vkontakte"
  get "services/send_twitter" => "services#send_twitter"
  get "services/send_linkedin"

  resources :services, :only => [:index, :create, :destroy] do
    collection do
      get 'signin'
      get 'signout'
      get 'signup'
      post 'newaccount'
      get 'failure'
    end
  end

  # used for the demo application only
  resources :users, :only => [:index] do
    collection do
      get 'test'
    end
  end
   
  root :to => "users#index"
  #root to: "services#signin"
end
