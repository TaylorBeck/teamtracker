Rails.application.routes.draw do
  root to: 'users#index'

  get '/register' => 'users#register'
  get '/login' => 'user_sessions#new'
  get '/logout' => 'user_sessions#destroy'
  post '/users' => 'users#create'
  get '/manage' => 'users#manage', as: :manage
  post '/receive_response_from_player' => 'rsvps#receive_response_from_player'

  resources :user_sessions, only: [:new, :create, :destroy]

  resources :teams do
    resources :team_player_details
  end

  resources :players
  resources :sports
  resources :games
  resources :rsvps, only: [:update]
end
