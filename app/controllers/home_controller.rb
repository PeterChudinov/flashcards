class HomeController < ApplicationController

  def index
    @card = current_user.cards.get_review_card
  end

  def login
    render 'user_sessions/form'
  end
end
