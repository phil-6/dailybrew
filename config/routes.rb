Rails.application.routes.draw do
  root 'pages#main'
  get 'about', to: 'pages#about'
  get 'subscription', to: 'pages#subscription'
  get 'terms', to: 'pages#terms'

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: :show

  devise_scope :user do
    patch '/update_subscription_interest', to: 'registrations#update_subscription_interest', as: 'update_subscription_interest'
  end

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

  get 'shelf_items', to: 'shelf_items#index', as: 'shelf_items'
  post 'shelf_items/:coffee_id', to: 'shelf_items#create', as: 'create_shelf_item'
  delete 'shelf_items/:coffee_id', to: 'shelf_items#destroy', as: 'delete_shelf_item'

  get 'favourites', to: 'favourites#index', as: 'favourites'
  post 'favourites/:coffee_id', to: 'favourites#create', as: 'create_favourite'
  delete 'favourites/:coffee_id', to: 'favourites#destroy', as: 'delete_favourite'

end
