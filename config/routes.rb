Rails.application.routes.draw do

  root 'home#home'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'

  get '/auth/:strategy/callback', to: 'sessions#create'

  resources :friendships

  resources :users do
    resources :posts
  end

  resources :posts do
    resources :comments
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
