class Card < ActiveRecord::Base

  before_validation(on: :create) do
    self.review_date = Date.today + 3.days	
  end

  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true

  validate :texts_are_not_matching

  def texts_are_not_matching
    ot = UnicodeUtils::downcase(original_text)
    tt = UnicodeUtils::downcase(translated_text)

    if ot.strip == tt.strip
      errors.add(:original_text, 'Оригинальный и переведенный текст не могут быть одинаковыми')
    end
  end

  def self.get_review_card
    self.where(["review_date < ?", Date.today]).order('RANDOM()').first
  end
end
