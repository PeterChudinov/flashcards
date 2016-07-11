class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_quiz_eligible_card_id

    @card = Card.order('RANDOM()').first

    while @card[:review_date] > Date.today
      @card = Card.order('RANDOM()').first
    end

    card_id = @card[:id]
  end
end
