Rails.application.routes.draw do

  get 'decks/choose'

  get 'decks/show'

  get 'decks/new'

  get 'decks/update'

  get 'decks/delete'

  get 'oauths/oauth'

  get 'oauths/callback'

  root 'home#index'
  resources :cards
  post 'trainer/:id/review' => 'trainer#review', as: 'trainer_review'

  get 'signup' => 'sign_up#new', :as => 'signup'
  post 'signup' => 'sign_up#create', :as => 'create_user'

  resources :users, only: [:show, :edit, :update]

  get 'signin' => 'sessions#new', :as => 'signin'
  post 'login' => 'sessions#create', :as => 'login'
  post 'logout' => 'sessions#destroy', :as => 'logout'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
