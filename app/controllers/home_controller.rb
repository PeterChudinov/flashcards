class HomeController < ApplicationController
  before_action :require_signin

  def index
    if current_user.current_deck.nil?
      @card = current_user.cards.get_review_card
    else
      @card = current_user.current_deck.get_review_card
    end
  end

  def login
    render 'user_sessions/form'
  end
end
