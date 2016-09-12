class DecksController < ApplicationController
  def index
    @decks = current_user.decks.all
  end

  def show
    @deck = current_user.decks.find(params[:id])
    redirect_to edit_deck_path(@deck)
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = current_user.decks.new(name: (params[:deck][:name]))
    if @deck.save
      redirect_to edit_deck_path(@deck)
    else
      redirect_to new_deck_path
    end
  end

  def edit
    @deck = current_user.decks.find(params[:id])
    @cards = @deck.cards.all
  end

  def set_user_current_deck
    @deck = current_user.decks.find((params[:deck_id]))
    current_user.set_current_deck!(@deck.id)
    redirect_to decks_path, notice: "LOCALE_CURRENT_DECK_SET_TO '#{@deck.name}'"
  end

  def destroy
    @deck = current_user.decks.find(params[:id])
    if @deck.destroy
      redirect_to decks_path, notice: 'LOCALE_DECK_DELETED'
    else
      redirect_to decks_path
      flash[:error] = 'LOCALE_DECK_DESTRUCTION_FAILED'
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name, [:deck][:name])
  end
end
