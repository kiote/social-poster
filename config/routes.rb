SocialPoster::Application.routes.draw do
  
  root "static_pages#home"
  
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :messages, only: [:create, :destroy]
  
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  
  match '/help', to: 'sessions#new', via: 'get'
  
  match '/authorise', to: 'authorisations#new', via: 'get'
  
  get "contact/:provider", to: 'contact#new'
  post "contact/create/:provider", to: 'contact#create'
  
  get '/auth/:provider/callback', to: 'authorisations#create'
  get '/auth/failure', to: 'authorisations#failure'
  
end
