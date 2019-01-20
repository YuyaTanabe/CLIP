Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions:      "admins/sessions",
    passwords:     "admins/paswwords",
    registrations: "admins/registrations"
  }

  devise_for :users, controllers: {
    sessions:      "users/sessions",
    passwords:     "users/passwords",
    registrations: "users/registrations"
  }

  #トップページをルートパスに指定
  root to: 'top#top'

  resources :admins, only: [:show]

  get 'users/clip'
  resources :users, only: [:index, :create, :show, :edit, :update, :destroy]

  resources :things

  resources :locations

  resources :friendships, only: [:new, :create, :index, :destroy]

  resources :rooms, only: [:create, :show, :destroy]

  resources :messages, only: [:create, :edit, :update, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
