Rails.application.routes.draw do
  get '/register' => 'users#register'
  get '/login' => 'users#login'
  post '/users' => 'users#create'

  resources :teams
  resources :players
  resources :sports
end
