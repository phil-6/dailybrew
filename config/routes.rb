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
  post 'roaster/:id/update_coffees', to: 'roasters#update_coffees', as: :update_roaster_coffees

  get '/dashboard/', to: 'dashboard#index'

end
