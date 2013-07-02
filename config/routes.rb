SocialPoster::Application.routes.draw do
  
  root :to => "sessions#new"
  
  get "sessions/new"
  get "sessions/create"
  get "sessions/failure"
  
  get '/login', :to => 'sessions#new', :as => :login
  get '/logout', :to => 'sessions#destroy'
  
  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/failure', :to => 'sessions#failure'
  
end
