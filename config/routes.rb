Rails.application.routes.draw do

  root 'home#index'
  resources :cards
  post '/' => 'home#grade_quiz'
end
