Rails.application.routes.draw do

  root 'home#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Add exceptions
  resources :users do
    resources :posts, only: [:create, :destroy]
  end

  resources :friendships, only: [:create, :destroy]
  resources :activities, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
