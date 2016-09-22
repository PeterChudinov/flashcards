class TrainerController < ApplicationController
  def review
    @card = Card.find(params[:id])
    @response = params[:response]

    result = @card.check_answer?(params[:response])
    if result
      @card.touch_review_date!
      flash[:notice] = "LOCALE_TRAINER_SUCCESS!"
    else
      flash[:notice] = "LOCALE_TRAINER_FAILURE_SHOULD_BE '#{@card.original_text}'"
    end
    redirect_to root_path
  end
end
