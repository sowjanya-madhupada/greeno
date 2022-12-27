Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :stores
  get 'gallery/index'
  get 'gallery/search'
  resources :carts, only: [:show, :destroy]
  resources :line_items, only: [:create, :destroy]
  post "line_item/:id/add", to: "line_items#add_quantity", as: "line_item_add"
  post "line_item/:id/reduce", to: "line_items#reduce_quantity", as: "line_item_reduce"
  resources :charges, only: [:new, :create]
  get 'admin' => 'admin#home'
  
  
  root to: "home#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
