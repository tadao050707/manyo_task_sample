Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :labels

  namespace :admin do
    resources :users
  end
end
