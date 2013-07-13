SocialPoster::Application.routes.draw do
  
  root to: "sessions#new"
  
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
