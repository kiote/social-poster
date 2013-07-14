SocialPoster::Application.routes.draw do
  
  get "messages/new"
  get "users/new"
  
  root to: "sessions#new"
  
  resources :users
  
  get '/signup', to: 'users#new'
  
  get "sessions/new"
  get "sessions/create"
  get "sessions/failure"
  
  get "contact/:provider", to: 'contact#new'
  post "contact/create/:provider", to: 'contact#create'
  
  get '/signin', to: 'sessions#new', as: :signin
  get '/signout', to: 'sessions#destroy'
  
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  
end
