Rails.application.routes.draw do
  get 'games/index'

  get 'games/new'

  get 'games/create'

  get 'games/show'

  get 'games/edit'

  get 'games/update'

  get 'games/destroy'

  get '/register' => 'users#register'
  get '/login' => 'users#login'
  post '/users' => 'users#create'

  resources :teams
end
