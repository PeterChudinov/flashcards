class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_review_eligible_card_id
    @card = Card.where(["review_date < ?", Date.today]).order('RANDOM()').first
    card_id = @card[:id]
  end
end
