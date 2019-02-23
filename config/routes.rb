Rails.application.routes.draw do

  root 'home#home'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'

  # Add exceptions
  resources :users do
    resources :posts
    # resources :comments
  end

  resources :friendships

  resources :posts do
    resources :comments
  end

  # resources :activities

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
