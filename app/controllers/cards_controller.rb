class CardsController < ApplicationController
  before_action :load_deck
  
  def index
    redirect_to deck_path(@deck)
  end

  def create
    @card = @deck.cards.new(card_params)
    if @card.save
      redirect_to deck_cards_path
    else
      flash[:error] = @card.errors.full_messages
      redirect_to new_deck_card_path
    end
  end

  def new
    @deck = current_user.decks.find(params[:deck_id])
    @card = @deck.cards.new
  end

  def edit
    @card = current_user.cards.find(params[:id])
  end

  def update
    @card = current_user.cards.find(params[:id])
    if @card.update!(card_params)
      redirect_to deck_cards_path
    else
      redirect_to action: edit
    end
  end

  def destroy
    @card = current_user.cards.find(params[:id])
    if @card.destroy!
      redirect_to edit_deck_path(@deck), notice: 'LOCALE_CARD_DELETED'
    else
      flash[:error] = 'LOCALE_CARD_DESTRUCTION_FAILED'
      redirect_to deck_cards_path
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image, :deck_id)
  end

  def load_deck
    @deck = current_user.decks.find(params[:deck_id])
  end
end
