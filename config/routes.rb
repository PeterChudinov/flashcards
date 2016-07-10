Rails.application.routes.draw do

  root 'home#index'

  resources :cards
  post 'trainer/test'
end
