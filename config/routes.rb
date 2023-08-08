Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'
 
  
  resources :users, only: [:index, :show, :edit, :update] do
   resource :relationships, only: [:create, :destroy]
  get :followings, on: :member
  get :followers, on: :member
  end
 
  
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
     resources :comments #追記
    collection do
      get :search
      get :result
    end
    resource :favorites, only: [:create, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]
   
    end
  end

 

