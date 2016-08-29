class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true
end
