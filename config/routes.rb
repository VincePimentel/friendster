Rails.application.routes.draw do

  root 'home#index'

  get 'test', to: 'home#test'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Add exceptions
  resources :users do
    resources :posts
    resources :comments
  end

  resources :posts do
    resources :comments
  end

  resources :friendships

  # resources :activities

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
