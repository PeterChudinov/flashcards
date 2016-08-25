class CardsController < ApplicationController
  
  def index
    @cards = current_user.cards.all.page(params[:page]).order(:review_date).reverse_order.per(20)
  end

  def create
    @deck = current_user.decks.find(params[:deck => [:deck_id]])
    @card = @deck.cards.new(card_params)
    if @card.save!
      redirect_to cards_path
    else
      flash[:error] = @card.errors.full_messages
      redirect_to new_card_path
    end
  end

  def new
    @card = current_user.current_deck.cards.new
    @deck = current_user.decks.find(params[:deck_id])
  end

  def edit
    @card = current_user.cards.find(params[:id])
    @deck = current_user.decks.find(params[:deck_id])
  end

  def update
    @card = current_user.cards.find(params[:id])
    if @card.update(card_params)
      @card.deck = params[:deck]
      redirect_to cards_path
    else
      redirect_to :action => :edit
    end
  end

  def destroy
    @card = current_user.cards.find(params[:id])
    if @card.destroy!
      redirect_to cards_path, notice: 'Карточка удалена!'
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image, :deck_id)
  end
end
