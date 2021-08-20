Rails.application.routes.draw do
  # root to: 'users#index'
  # get 'users', to: 'users#index'

  namespace :api do
    namespace :v1 do
      resources :teams, only: [:show, :create, :update, :destroy]
      # resources :users
    end
  end
end
