Rails.application.routes.draw do
  get 'users/index'
  resources :reservations
  devise_for :users
  resources :homes
  resources :pets
  resources :users, only: [:show] do
    collection do 
      get :profile
    end
  end


  get '/homes/:id/delete' => 'homes#destroy', as: 'homes_delete'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  match '/users',   to: 'users#index',   via: 'get'

  put '/users/:id', action: :verify, controller: 'users'

  post "/search_homes" => "homes#search"
  get "/search_homes" => "homes#index"

  get '/homes/search_homes', action: :index, controller: 'homes'
end
