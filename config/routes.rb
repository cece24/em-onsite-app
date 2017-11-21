Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  resources :pages

  get '/access', to: "pages#access", as: "access"

  get '/sendalert', to: "pages#sendalert", as: "alert"

  resources :sessions, only: %i(create new destroy)
  resources :alerts, only: %i(create new)
end
