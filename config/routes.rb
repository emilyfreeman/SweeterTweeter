Rails.application.routes.draw do
  root 'welcome#index'
  resources :welcome, only: [:index]
  resources :favorites, only: [:create]
  resource :status, controller: :status, only: [:create]
  get '/auth/twitter', as: :login
  get '/auth/twitter/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'profile', to: 'profile#show'
end
