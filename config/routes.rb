Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'register', to: 'user_registrations#new'
  post 'register/user', to: 'user_registrations#create'
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  get 'new_supervisor', to: 'users#new_supervisor'
  post 'create_supervisor', to: 'users#create_supervisor'
  delete 'logout', to: 'user_sessions#destroy', as: :logout
  root 'users#show'

  resources :user_sessions, only: %i[new create destroy]
  resources :users, shallow: true do
    member do
      get 'edit_supervisor', to: :edit_supervisor
      post 'update_supervisor', to: :update_supervisor
      post 'delete_supervisor', to: :delete_supervisor
      get 'show_supervisor', to: :show_supervisor
    end
    resources :wallets, shallow: true do
      resources :cards do
        get :edit, on: :collection
      end
    end
  end

  resources :cars

  get 'index_ver_mas_autos', to: 'cars#index_ver_mas_autos'

  resources :cars, shallow: true do
    member do
      post 'remove_car', to: :remove_car
      post 'block', to: :block
    end
  end

  resources :rentals, shallow: true do
    resources :feed_backs
    post 'generate', to: 'rentals#generate'
  end
  resources :fines

  resources :licenses

  resources :locations, only: :create

  get 'history', to: 'licenses#history'

  resources :reports
  get 'reports_fines', to: 'reports#fines'
  get 'reports_fines_generate', to: 'reports#fines_generate'
  get 'payfine', to: 'fines#pay_fine'

  get 'reports_rentals', to: 'reports#rentals'
  get 'reports_rentals_generate', to: 'reports#rentals_generate'

  get 'reports_users', to: 'reports#users'
  get 'reports_users_generate', to: 'reports#users_generate'

  resources :reset_passwords, only: %i[new create update edit]

  post 'update_price', to: 'prices#update_price'
  get 'edit_price', to: 'prices#edit_price'
end
