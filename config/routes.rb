Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  
  resources :users, only: [:index, :show, :patch] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:create]
      resources :likes, only: [:create]
    end
  end
end
