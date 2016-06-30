class CardsController < ApplicationController
  
  def index
    @cards = Card.all
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to cards_path
    else
      redirect_to new_card_path
    end
  end

  def new
    @card = Card.new
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to cards_path
    else
      redirect_to :action => :edit
    end
  end

  def destroy
    @card = Card.find(params[:id])
    if @card.destroy!
      redirect_to cards_path, notice: 'Карточка удалена!'
    end
  end

  private
    def card_params
      params.require(:card).permit(:original_text, :translated_text)
    end
end
