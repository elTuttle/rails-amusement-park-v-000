Rails.application.routes.draw do
  resources :users
  resources :attractions
  root 'users#welcome'

  get '/signin', to: 'users#sign_in'
  post '/signinpost', to: 'users#sign_in_post'

  post '/attractions/:id/ride', to: 'attractions#ride'

end
