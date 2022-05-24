Rails.application.routes.draw do
  devise_for :users
  resources :reservations, except: [:destroy]
  resources :reviews, only: [:show, :new, :create]
  resources :homes
  resources :pets
  resources :users, only: [:show] do
    collection do 
      get :profile
    end
  end

  get '/homes/:id/reviews' => 'reviews#index', as: 'homes_reviews'
  get '/homes/:id/delete' => 'homes#destroy', as: 'homes_delete'
  get 'users/index'

  root "pages#home"

  match '/users',   to: 'users#index',   via: 'get'

  put '/users/:id', action: :verify, controller: 'users'

  post "/search_homes" => "homes#search"
  get "/search_homes" => "homes#index"

  get '/homes/search_homes', action: :index, controller: 'homes'
end
