Rails.application.routes.draw do
  root 'pages#main'
  get 'about', to: 'pages#about'
  get 'subscription', to: 'pages#subscription'

  devise_for :users

  scope module: 'admin' do
    get '/admin/dashboard', to: 'admin#index'
    resources :roasters, only: [:new, :create, :edit, :update]
  end

  resources :brews
  resources :coffees
  resources :roasters, only: [:index, :show]

end
