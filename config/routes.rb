Rails.application.routes.draw do
  resources :bookings
  resources :shows
  resources :time_slots
  resources :movies
  resources :screens
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'movies#index'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
