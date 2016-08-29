Rails.application.routes.draw do

  root 'home#index'
  
  resources :decks do
    post 'current' => 'decks#set_user_current_deck', as: 'set_current'
    resources :cards
  end

  post 'trainer/:id/review' => 'trainer#review', as: 'trainer_review'

  get 'signup' => 'sign_up#new', :as => 'signup'
  post 'signup' => 'sign_up#create', :as => 'create_user'

  resources :users, only: [:show, :edit, :update]

  get 'signin', to: 'sessions#new', as: 'signin'
  post 'login', to:'sessions#create', as: 'login'
  post 'logout', to: 'sessions#destroy', as: 'logout'

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
end
