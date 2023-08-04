Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'
  
  resources :users, only: [:index, :show, :edit, :update] do
     member do
      get :follower, :followers
    end
      resource :relationships, only: [:create, :destroy]
  end
 
  
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
     resources :comments #追記
    collection do
      get :search
      get :result
    end
    resource :favorites, only: [:create, :destroy]
  end
 end
 

