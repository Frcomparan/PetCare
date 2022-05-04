Rails.application.routes.draw do
  devise_for :users
  resources :homes, except: [:delete]
  resources :pets

  get '/homes/:id/delete' => 'homes#destroy', as: 'homes_delete'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end
