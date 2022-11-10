Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'register', to: 'user_registrations#new'
  post 'register/user', to: 'user_registrations#create'
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  get 'new_supervisor', to: 'new_supervisor#new'
  post 'create_supervisor', to: 'create_supervisor#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout
  root 'user_sessions#show'

  resources :user_sessions, only: %i[new create destroy]
  resources :users, shallow: true do
    member do
      get 'edit_supervisor', to: :edit_supervisor
      post 'update_supervisor', to: :update_supervisor
    end
    resources :wallets, shallow: true do
      resources :cards do
        get :edit, on: :collection
      end
    end
  end

  resources :cars

  resources :licenses
  

end
