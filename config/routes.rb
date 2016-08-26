Rails.application.routes.draw do
  root 'home#index'
  
  get 'oauths/oauth'
  get 'oauths/callback'

  resources :decks do 
    resources :cards do
      post 'decks', to: 'decks#create'
      patch 'decks/:id', to: 'decks#create'
    end
  end

  post 'decks/switch/:id', to: 'decks#switch', as: 'switch_deck'
  post 'decks/:id', to: 'decks#add_card_to_deck', as: 'add_card_to_deck'
  patch 'decks/:id', to: 'decks#add_card_to_deck'
  delete 'decks/card/:id', to: 'decks#remove_card_from_deck', as: 'remove_card_from_deck'

  post 'trainer/:id/review', to: 'trainer#review', as: 'trainer_review'
=begin
  get 'decks', to: 'decks#choose', as: 'decks'
  get 'decks/new', to: 'decks#new', as: 'new_deck'
  post 'decks', to: 'decks#create'
  get 'decks/:id', to: 'decks#show', as: 'deck'
  get 'decks/:id/edit', to: 'decks#edit', as: 'edit_deck'
  post 'decks/switch/:id', to: 'decks#switch', as: 'switch_deck'
  post 'decks/:id', to: 'decks#add_card_to_deck', as: 'add_card_to_deck'
  patch 'decks/:id', to: 'decks#add_card_to_deck'
  delete 'decks/card/:id', to: 'decks#remove_card_from_deck', as: 'remove_card_from_deck'
=end
  get 'signup', to: 'sign_up#new', as: 'signup'
  post 'signup', to: 'sign_up#create', as: 'create_user'

  resources :users, only: [:show, :edit, :update]

  get 'signin', to: 'sessions#new', as: 'signin'
  post 'login', to:'sessions#create', as: 'login'
  post 'logout', to: 'sessions#destroy', as: 'logout'

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
end
