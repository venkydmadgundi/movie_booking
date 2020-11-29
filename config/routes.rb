Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :bookings
  resources :shows
  resources :time_slots
  resources :movies
  resources :screens
  root 'bookings#index'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'populate_show', to: 'bookings#populate_show', as: 'populate_show'
  get 'populate_screen', to: 'bookings#populate_screen', as: 'populate_screen'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
