Rails.application.routes.draw do
  root 'home#index'
  resources :cards
  post 'trainer/:id/review' => 'trainer#review', as: 'trainer_review'

  get 'users/new' => 'users#new', as: 'users'
  post 'users/new' => 'users#create', as: 'new_user'
  get 'signin' => 'user_sessions#new', :as => 'sign_in'
  post 'login' => 'user_sessions#create', :as => 'login'
  post 'logout' => 'user_sessions#destroy', :as => 'logout'
end
