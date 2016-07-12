class TrainerController < ApplicationController
  def review
    @card = Card.find(params[:id])
    @response = params[:response]

    if UnicodeUtils::downcase(@response).strip.eql? UnicodeUtils::downcase(@card[:original_text]).strip
      @card.update(:review_date => (Date.today + 3))
      flash[:notice] = "Верно!"
    else
      flash[:notice] = "Неверно!"
    end
    redirect_to root_path
  end
end
