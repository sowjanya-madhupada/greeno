Rails.application.routes.draw do
  get 'admin' => 'admin#home'
  devise_for :users
  resources :users
  #get 'home/index'
  root to: "home#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
