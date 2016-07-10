class TrainerController < ApplicationController
  def check
    @card = Card.find(2399)
  end

  def test
    @card = Card.find(params[:id])
    if params[:user_input].eql? @card[:original_text]
      redirect_to card_path(@card), notice: "uspeh"
    else
      redirect_to root_path, notice: "ne ochen"
    end
  end
end
