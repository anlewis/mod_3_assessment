Rails.application.routes.draw do
  root "plays#new"

  resources :plays, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        resources :plays, only: [:create]
      end
    end
  end
end
