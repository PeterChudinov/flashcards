class HomeController < ApplicationController
  before_filter :require_signin

  def index
    @card = current_user.cards.get_review_card
  end

  def login
    render 'user_sessions/form'
  end
end
