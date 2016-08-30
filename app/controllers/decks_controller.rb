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
    @deck.save!
    redirect_to edit_deck_path(@deck)
  end

  def edit
    @deck = current_user.decks.find(params[:id])
    @cards = @deck.cards.all
  end

  def set_user_current_deck
    @user = current_user
    @deck = current_user.decks.find(params[:deck_id])
    @user.set_current_deck(@deck.id)
    @user.save!
    redirect_to decks_path, notice: "LOCALE_CURRENT_DECK_SET_TO '#{@deck.name}'"
  end

  def destroy
    @deck = current_user.cards.find(params[:id])
    if @deck.destroy!
      redirect_to decks_path, notice: 'LOCALE_DECK_DELETED'
    else
      flash[:error] = 'LOCALE_DECK_DESTRUCTION_FAILED'
      redirect_to decks_path
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name, [:deck][:name])
  end
end
