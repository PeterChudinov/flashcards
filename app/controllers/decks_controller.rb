class DecksController < ApplicationController
  def index
    @decks = current_user.decks.all
  end

  def switch
    @user = current_user
    @user.current_deck_id = params[:id]
    @user.save!
    redirect_to decks_path
    flash[:notice] = "#{t('views.decks.switch.using')} '#{current_user.decks.find(current_user.current_deck_id).name}' #{t('views.decks.switch.as_main_deck')}"
  end

  def show
    @deck = current_user.decks.find(params[:id])
    @cards = current_user.cards
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = current_user.decks.new(deck_params)
    if @deck.save!
      redirect_to decks_path
    else
      flash[:notice] = @deck.errors.full_messages
      redirect_to new_deck_path
    end
  end

  def remove_card_from_deck
    @card = current_user.cards.find(params[:id])
    @deck = current_user.decks.find(@card.deck_id)
    redirect_to deck_path
  end

  def add_card
    add_card_to_deck
  end

  def add_card_to_deck
    @deck = current_user.decks.find(params[:id])
    @card = current_user.cards.find(params[:card_id])
    @card.deck_id = @deck.id
    @card.save!
    redirect_to deck_path(@deck)
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :card)
  end
end
