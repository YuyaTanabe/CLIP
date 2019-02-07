Rails.application.routes.draw do

  get 'guide/guide'
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

  get 'admins/top' => 'admins#top'

  get 'admins/users/unsubscribed' => 'admins/users#unsubscribed'

  namespace :admins do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :things, only: [:index, :show, :edit, :update, :destroy]
    resources :locations, only: [:index, :show, :edit, :update, :destroy]
  end

  get 'admins/users/:id/unsubscribed_show/' => 'admins/users#unsubscribed_show', as: 'unsubscribed_show_user'
  patch 'admins/users/:id/revive' => 'admins/users#revive_account', as: 'revive_account_user'

  get 'users/clip'
  resources :users, only: [:create, :show, :edit, :update, :destroy]

  resources :things, only: [:new, :create, :show, :edit, :update, :destroy]

  resources :locations, only: [:new, :create, :show, :edit, :update, :destroy]

  resources :friendships, only: [:new, :create, :index, :destroy]

  resources :rooms, only: [:create, :show, :destroy]

  resources :messages, only: [:create, :edit, :update, :destroy]

  get  'inquiries/index' =>'inquiries#index'
  post 'inquiries/confirm' => 'inquiries#confirm'
  post 'inquiries/done' => 'inquiries#done'

  get  'top/guide' =>'top#guide'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
