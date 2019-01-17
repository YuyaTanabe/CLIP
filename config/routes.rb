Rails.application.routes.draw do

  # devise_for :admins
  devise_for :admins, controllers: {
        sessions: "admins/sessions",
        passwords: "admins/paswwords",
        registrations: "admins/registrations"
  }


  #トップページをルートパスに指定
  root to: 'top#top'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
