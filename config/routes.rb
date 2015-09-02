Rails.application.routes.draw do
  devise_for :users
  resources :list_items, only: [:index, :create, :destroy, :show]
  resources :requested_items, only: [:create]
end
