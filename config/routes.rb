SocialPoster::Application.routes.draw do
  
  root :to => "users#index"
  
  get '/auth/:service/callback' => 'services#create'
  
  get "/signin" => "services#signin"
  get "/signout" => "services#signout"
  
  
  get '/auth/failure' => 'services#failure'
  
  #~ get '/send_message/', to: 'send_message#index'
  get "send_message/index" => "send_message#index"
  
  #~ get "services/send_facebook"
  #~ get "services/send_vkontakte"
  #~ get "services/send_twitter"
  #~ get "services/send_linkedin"

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

end
