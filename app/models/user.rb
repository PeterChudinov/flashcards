class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :cards, through: :decks
  has_many :decks
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  attr_accessor :current_user

  def current_deck
    if current_deck_id.nil?
      return
    else
      self.decks.find(current_deck_id)
    end
  end

  # TODO, FIX!
  def set_current_deck(id)
    self.current_deck_id = id
  end
end
