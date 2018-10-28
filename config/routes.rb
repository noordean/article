Rails.application.routes.draw do
  resources :users
  resources :submissions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "submissions#new"
end
