Rails.application.routes.draw do

  root 'home#index'
  resources :cards
  post 'trainer/:id/review' => 'trainer#review', as: 'trainer_review'

  get 'signup' => 'sign_up#new', :as => 'signup'
  post 'signup_create' => 'sign_up#create', :as => 'create_user'

  get 'profile/:id/edit' => 'users#edit', :as => 'profile_settings'
  patch 'profile/:id' => 'users#update'

  get 'users' => 'users#index', :as => 'user'

  get 'signin' => 'sessions#new', :as => 'sign_in'
  post 'login' => 'sessions#create', :as => 'login'
  post 'logout' => 'sessions#destroy', :as => 'logout'
end
