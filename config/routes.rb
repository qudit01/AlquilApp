Rails.application.routes.draw do
  resources :fines

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

  resources :licenses

  resources :locations, only: :create

  get 'history', to: 'licenses#history'
<<<<<<< HEAD
  get 'payfine', to: 'fines#pay_fine'
=======

>>>>>>> 20f20d701ed23a234651f4c2cc62a80af5aec90e
end
