SocialPoster::Application.routes.draw do
  
  get "messages/new"
  
  root to: "sessions#new"
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  
  match '/help', to: 'sessions#new', via: 'get'
  
  get "sessions/failure"
  
  get "contact/:provider", to: 'contact#new'
  post "contact/create/:provider", to: 'contact#create'
  
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  
end
