Rails.application.routes.draw do
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
end
