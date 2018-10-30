Rails.application.routes.draw do
  get 'sessions/new'
  resources :users
  resources :submissions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "submissions#new"
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#login'
  get '/logout',  to: 'sessions#logout'
end
