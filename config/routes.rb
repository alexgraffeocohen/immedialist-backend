Rails.application.routes.draw do
  devise_for :users
  root 'ember#bootstrap'
  resources :list_items, only: [:index, :create, :destroy]
  resources :requested_items, only: [:create]
end
