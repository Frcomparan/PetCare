Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  resources :homes
  resources :pets
  resources :users, only: [:show] do
    collection do 
      get :profile
    end
  end

  root "pages#home"

  match '/users',   to: 'users#index',   via: 'get'
end
