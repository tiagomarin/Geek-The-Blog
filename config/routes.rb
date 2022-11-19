Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  
  devise_for :users
  root to: "users#index"
  
  resources :users, only: [:index, :show, :patch] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create]
    end
  end
  
  # API ROUTES
  namespace :api do # /api
    namespace :v1 do # /api/v1
      resources :users, only: [:index,:show, :create] do # api/v1/users
        resources :posts, only: [:index,:show], format: :json do # api/v1/users/:user_id/posts
          resources :comments, format: :json # api/v1/users/:user_id/posts/:post_id/comments
        end
      end
    end
  end
  post "/login", to: "authors#login"
end
