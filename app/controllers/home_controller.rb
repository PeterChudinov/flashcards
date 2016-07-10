class HomeController < ApplicationController
  def index
    render 'trainer/check'
    @card = Card.find(2401)
  end

  def test 
  end
end
