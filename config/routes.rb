Rails.application.routes.draw do
  root to: 'teams#index'

  get '/register' => 'users#register'
  get '/login' => 'user_sessions#new'
  get '/logout' => 'user_sessions#destroy'
  post '/users' => 'users#create'

  resources :user_sessions, only: [:new, :create, :destroy]

  resources :teams
  resources :players
  resources :sports
end
