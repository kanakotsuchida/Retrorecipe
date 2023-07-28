Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'
  
  resources :users, only: [:index, :show, :edit, :create, :update]
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
end
