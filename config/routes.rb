Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  
  resources :users, only: [:index, :show, :patch, :destroy] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create]
    end
  end
end
