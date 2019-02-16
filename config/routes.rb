Rails.application.routes.draw do

  root 'home#index'

  resources :users do
    resources :posts, only: [:create, :destroy]
  end

  resources :friendships
  resources :activities

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
