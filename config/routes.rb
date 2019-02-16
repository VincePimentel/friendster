Rails.application.routes.draw do

  resources :users do
    resources :posts, only: [:create, :destroy]
  end

  resources :friendships
  resources :activities

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
