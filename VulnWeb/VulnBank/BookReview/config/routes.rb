Rails.application.routes.draw do
  resources :users
  resources :books
  root 'books#index'
end
