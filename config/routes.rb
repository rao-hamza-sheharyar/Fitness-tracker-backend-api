Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # home page routes
  root "pages#home"

  # api  routes
  namespace :api do
    namespace :v1 do

      resources :users
      post 'signup', to: 'registrations#create'
      get 'verify_email', to: 'registrations#verify'
      post 'login', to: 'sessions#create'

      resources :diet_plans, only: [:create, :show, :update, :destroy]
      get 'users/:id/diet_plans', to: 'diet_plans#user_plans'

    end
  end
end
