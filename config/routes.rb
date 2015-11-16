Rails.application.routes.draw do
  root "application#home"

  get "login" => "user_sessions#new", as: :login
  get "logout" => "user_sessions#destroy", as: :logout

  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :show, :new, :create, :destroy]
  resources :guests, only: [:create, :edit, :update]
  resources :shots, only: [:index, :new, :create, :destroy] do
    get "confirmation", on: :collection
  end
  resources :tags, only: [:index]
  resource :pin, only: [:create, :destroy]
  resource :profile, only: :show
end
