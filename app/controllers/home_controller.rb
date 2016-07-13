class HomeController < ApplicationController
  def index
    @card = Card.get_review_card
    render 'quiz'
  end
end
