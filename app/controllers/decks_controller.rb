class DecksController < ApplicationController
  def choose
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

  def update
  end

  def delete
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :card)
  end
end
