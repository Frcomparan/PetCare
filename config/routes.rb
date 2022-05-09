Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  resources :homes
  resources :pets

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  match '/users',   to: 'users#index',   via: 'get'
end
