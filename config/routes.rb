Rails.application.routes.draw do
  root 'home#index'
  
  get 'oauths/oauth'
  get 'oauths/callback'

  resources :cards
  post 'trainer/:id/review' => 'trainer#review', as: 'trainer_review'

  get 'decks' => 'decks#choose', as: 'decks'
  get 'decks/new' => 'decks#new', as: 'new_deck'
  post 'decks' => 'decks#create'
  get 'decks/:id', to: 'decks#show', as: 'deck'
  get 'decks/:id/edit', to: 'decks#edit', as: 'edit_deck'
  post 'decks/switch/:id', to: 'decks#switch', as: 'switch_deck'

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
