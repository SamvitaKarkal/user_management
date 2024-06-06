Rails.application.routes.draw do
  resources :users, only: [:index, :destroy]
  resources :daily_records, only: [:index]
end
