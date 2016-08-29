class HomeController < ApplicationController
  before_action :require_signin

  def index
    if (@deck = current_user.current_deck).nil?
      @cards = current_user.cards
    else
      @cards = @deck.cards
    end
    @card = @cards.get_review_card
  end

  def login
    render 'user_sessions/form'
  end
end
