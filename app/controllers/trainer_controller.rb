class TrainerController < ApplicationController
  def quiz
    card_id = get_quiz_eligible_card_id
    @card = Card.find(card_id)
  end
end
