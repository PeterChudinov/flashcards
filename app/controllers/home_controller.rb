class HomeController < ApplicationController
  before_action :require_signin

  def index
    if (@deck = current_user.current_deck).nil?
      @cards = current_user.cards.get_review_card
    else
      @cards = @deck.get_review_card
    end
  end

  def login
    render 'user_sessions/form'
  end
end
