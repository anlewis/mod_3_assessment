Rails.application.routes.draw do
  root "play#new"

  resources :play, only: [:new, :create]
end
