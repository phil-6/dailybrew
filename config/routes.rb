Rails.application.routes.draw do
  root 'pages#main'
  get 'about', to: 'pages#about'
  get 'subscription', to: 'pages#subscription'

  devise_for :users

  namespace :admin do
    get 'dashboard', to: 'index'
  end

  resources :brews
  resources :coffees
  resources :roasters

  get '/dashboard/', to: 'dashboard#index'

end
