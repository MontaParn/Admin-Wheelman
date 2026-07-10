Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "dashboard#index"
  get "podium", to: "podium#index"
  get "calendar", to: "calendar#index"

  resources :athletes do
    resources :memberships, only: %i[new create edit update]
    resources :race_entries, only: %i[new create destroy]
  end

  resources :payments, only: %i[update]
  resources :reminders, only: %i[create]
  resources :package_plans, except: %i[show]

  resources :events do
    resources :event_attendances, only: %i[create destroy]
  end
end
