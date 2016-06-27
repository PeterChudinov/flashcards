class CardsController < ApplicationController
  helper ApplicationHelper
  
  def index
    @cards = Card.all
  end

  def create
  	params.permit!
    @card = Card.new(params[:card])
    if(@card.save)
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def new
    @card = Card.new
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    params.permit!
    @card = Card.find(params[:id])
    @card.update(params[:card])
    redirect_to cards_path
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy!
    redirect_to cards_path
  end
end
