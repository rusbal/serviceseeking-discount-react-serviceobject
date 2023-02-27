Rails.application.routes.draw do
  resources :orders, only: [:create]
  root to: "main#index"
end
