Rails.application.routes.draw do

  root 'home#index'
  resources :cards
  post 'trainer/:id/review' => 'trainer#review', as: 'trainer_review'

  get 'signup' => 'sign_up#new', :as => 'signup'
  post 'signup_create' => 'sign_up#create', :as => 'create_user'

  resources :users, only: [:show, :edit, :update]

  get 'signin' => 'sessions#new', :as => 'signin'
  post 'login' => 'sessions#create', :as => 'login'
  post 'logout' => 'sessions#destroy', :as => 'logout'
end
