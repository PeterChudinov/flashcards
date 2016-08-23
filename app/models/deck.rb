class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  validates :name, presence: true, length: { minimum: 4, maximum: 20 }
  validates_associated :cards

  def get_review_card
    self.cards.where(["review_date < ?", Date.today]).order('RANDOM()').first
  end
end
