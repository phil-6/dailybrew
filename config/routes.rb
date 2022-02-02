Rails.application.routes.draw do
  root 'pages#main'
  get 'about', to: 'pages#about'
  get 'subscription', to: 'pages#subscription'

  devise_for :users

  resources :brews
  resources :coffees
  resources :roasters

end
