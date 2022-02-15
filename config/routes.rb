Rails.application.routes.draw do
  root 'pages#main'
  get 'about', to: 'pages#about'
  get 'subscription', to: 'pages#subscription'
  get 'terms', to: 'pages#terms'

  devise_for :users
  resources :users, only: :show

  namespace :admin do
    get 'dashboard'
  end
  get 'dashboard', to: 'dashboard#index'

  resources :roasters do
    resources :coffees, shallow: true
    post 'update_coffees', on: :member
  end
  resources :coffees, only: :index
  resources :brews
  resources :shelf_items
  resources :favourites
end
