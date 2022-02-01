Rails.application.routes.draw do
  root 'pages#main'
  get 'pages/about'

  devise_for :users

  resources :brews
  resources :coffees
  resources :roasters

end
