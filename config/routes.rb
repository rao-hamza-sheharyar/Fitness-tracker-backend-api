Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # home page routes
  root "pages#home"

  # after sign up and login
  get '/users' => 'activitys#index', as: :user_root # creates user_root_path

  # devise routes


  # activities resources
  resources :activitys

  # api  routes
  namespace :api do
    namespace :v1 do
      post 'signup', to: 'registrations#create'
      get 'verify_email', to: 'registrations#verify'
      post 'login', to: 'sessions#create'
      resources :users
    end
  end
end
