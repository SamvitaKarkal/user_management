Rails.application.routes.draw do
  root 'users#index'

  resources :users, only: [:index, :destroy]
  resources :daily_records, only: [:index]
end
