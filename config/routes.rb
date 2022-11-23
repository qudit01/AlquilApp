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
    end
    resources :wallets, shallow: true do
      resources :cards do
        get :edit, on: :collection
      end
    end
  end


  resources :cars
  
  resources :cars, shallow: true do
    member do
      post 'remove_car', to: :remove_car
    end
  end

  resources :licenses

  resources :locations, only: :create
  
 

end
