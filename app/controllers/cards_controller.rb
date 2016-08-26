class CardsController < ApplicationController
  
  def index
    @cards = current_user.cards.all.page(params[:page]).order(:review_date).reverse_order.per(20)
  end

  def create
    @card = current_user.current_deck.cards.new
    @card.user_id = current_user.id
    @card.deck_id = current_user.current_deck.id
    @card.original_text = params[:deck][:card][:original_text]
    @card.translated_text = params[:deck][:card][:translated_text]
    #@card.deck_id = current_user.decks.find(params[:deck_id])
   #@card = @deck.cards.new(card_params)
    if @card.save!
      redirect_to deck_cards_path
    else
      flash[:error] = @card.errors.full_messages
      redirect_to new_card_path
    end
  end

  def new
    @card = current_user.current_deck.cards.new
    @deck = current_user.current_deck
  end

  def edit
    @card = current_user.cards.find(params[:deck_id].id)
    @deck = current_user.decks.find(params[:deck_id].deck)
  end

  def update
    @card = current_user.cards.find(params[:id])
    if @card.update(card_params)
      @card.deck = params[:deck]
      redirect_to cards_path
    else
      redirect_to action: edit
    end
  end

  def destroy
    @card = current_user.cards.find(params[:id])
    if @card.destroy!
      redirect_to decks_cards_path, notice: 'Карточка удалена!'
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image, :card, :deck_id)
  end
end
