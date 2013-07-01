SocialPoster::Application.routes.draw do
  
  root :to => "sessions#new"
  
  get "sessions/new"
  get "sessions/create"
  get "sessions/failure"
  
  get '/login', :to => 'sessions#new', :as => :login
  get '/logout', :to => 'sessions#destroy'
  
  #~ get '/send_message/:provider', :to => 'send_message#new'
  
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'
  
end
