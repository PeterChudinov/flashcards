class HomeController < ApplicationController
  def index
    @card = Card.find(get_quiz_eligible_card_id)
    @card_text = @card[:translated_text]
    @card_id = @card[:id]
    render 'trainer/quiz'
  end

  def grade_quiz
    @card = Card.find(params[:card_id])
    @response = params[:response]

    if @response.eql? @card[:original_text]
      @card.update(:review_date => (Date.today + 3))
      flash[:notice] = "Верно!"
      redirect_to root_path
    else
      flash[:notice] = "Неверно!"
      redirect_to root_path
    end
  end
end
