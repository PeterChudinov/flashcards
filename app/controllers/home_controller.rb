class HomeController < ApplicationController
  def index
    @card = Card.find(get_review_eligible_card_id)
    render 'trainer/quiz'
  end
end
