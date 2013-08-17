
SocialPoster::Application.routes.draw do
  
  root "static_pages#home"
  
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
  match '/vcontact', to: 'vkontakte_connection#contact', via: 'get'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :messages, only: [:create, :destroy]
  resources :authorisations, only: [:create, :destroy]
  
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  
  match '/authorise', to: 'authorisations#new', via: 'get'
  
  get '/auth/:provider/callback', to: 'authorisations#create'
  get '/auth/failure', to: 'authorisations#failure'
  
end
