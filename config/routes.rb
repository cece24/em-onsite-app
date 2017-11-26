Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'

  resource :sessions, only: %i(create new destroy)

  resources :organizations, only: %i(index) do
    resources :events, only: %i(index show) do
      resources :alerts, only: %i(create new)
      resources :surveys, only: %i(index) do
        member do
          patch :survey_hide
          patch :survey_show
        end
      end
      resources :session_details do
        member do
          post :question_enable
          post :question_disable
          post :poll_show
          post :poll_hide
        end
      end
    end
  end

end
