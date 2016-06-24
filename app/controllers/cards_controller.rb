class CardsController < ApplicationController
  helper ApplicationHelper
  
  def index
    @cards = Card.all
  end
end
