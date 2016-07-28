class HomeController < ApplicationController
  def index
    @card = Card.get_review_card
  end

  def login
    render 'user_sessions/form'
  end
end
