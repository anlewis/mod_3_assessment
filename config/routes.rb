Rails.application.routes.draw do
  root "welcome#index"

  resources :play, only: [:create]
end
