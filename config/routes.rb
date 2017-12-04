Rails.application.routes.draw do
  resources :users
  resources :attractions
  root 'users#welcome'

  get '/signin', to: 'users#signin'
  post '/signinpost', to: 'users#signinpost'

  post '/attractions/:id/ride', to: 'attractions#ride'

end
