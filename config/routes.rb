Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :line_items
  resources :carts
  get 'gallery/index'
  # get 'gallery/search'
  resources :stores
  get 'admin' => 'admin#home'
  
  #get 'home/index'
  root to: "home#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
