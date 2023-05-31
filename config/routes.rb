Rails.application.routes.draw do
  root to: "cars#landing"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :cars
  # get 'user_session', to: 'users/sessions#show'
  resources :users, only: [:show]
  resources :transactions, only: [:index, :show, :create, :destroy] do
    resources :reviews
  end
end
