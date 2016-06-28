Rails.application.routes.draw do
  get 'sports/index'

  get 'sports/new'

  get 'sports/create'

  get 'sports/show'

  get 'sports/edit'

  get 'sports/update'

  get 'sports/destroy'

  get '/register' => 'users#register'
  get '/login' => 'users#login'
  post '/users' => 'users#create'

  resources :teams

  resources :sports

end
