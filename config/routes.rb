Rails.application.routes.draw do


  get 'friendships/index'
  get 'friendships/new'
  get 'friendships/create'
  get 'friendships/destroy'
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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
