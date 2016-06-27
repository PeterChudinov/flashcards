class Card < ActiveRecord::Base

  before_validation(on: :create) do
    self.review_date = Date.today + 3.days	
  end

  validates :original_text, presence: true
  validates :translated_text, presence: true

  validates :review_date, presence: true

  validate do
    if (original_text == translated_text)
      errors.add(:base, 'Оригинальный и переведенный текст не могут быть одинаковыми')
    end
  end
end
