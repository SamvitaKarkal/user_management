Rails.application.routes.draw do
  resources :users, only: [:index, :destroy]
end
