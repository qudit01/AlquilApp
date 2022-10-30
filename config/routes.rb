Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'register', to: 'user_registrations#new'
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout
  root 'home#show'

  resources :user_sessions, only: %i[new create destroy]
  resources :users do
    member do
      get 'edit_supervisor', to: :edit_supervisor
      post 'update_supervisor', to: :update_supervisor
    end
  end
end
