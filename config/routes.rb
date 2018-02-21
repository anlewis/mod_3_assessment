Rails.application.routes.draw do
  root "play#new"

  resources :play, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :games, only: [:show]
    end
  end
end
