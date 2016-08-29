class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck

  has_attached_file :image, styles: { medium: "300x300#", thumb: "20x20#" }
  validates_attachment :image,
    content_type: {
      content_type: ["image/jpeg", "image/gif", "image/png"]
    }

  before_validation(on: :create) do
    self.review_date = 3.days.from_now.end_of_day
  end

  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true

  validate :texts_are_not_matching

  validates :user_id, presence: true
  validates :deck_id, presence: true

  def texts_are_not_matching
    ot = UnicodeUtils::downcase(original_text.strip)
    tt = UnicodeUtils::downcase(translated_text.strip)

    update_attribute(:original_text, ot)
    update_attribute(:translated_text, tt)

    if ot == tt
      errors.add(:original_text, 'Оригинальный и переведенный текст не могут быть одинаковыми')
    end
  end

  def self.get_review_card
    self.where(["review_date < ?", Date.today]).order('RANDOM()').first
  end

  def check_answer?(response)
    UnicodeUtils::downcase(response).strip == UnicodeUtils::downcase(original_text).strip
  end

  def touch_review_date!
    update_column(:review_date, 3.days.from_now.end_of_day)
  end

  # For testing purpouses only
  def set_test_review_date!
    update_column(:review_date, 5.days.ago.end_of_day)
  end
end
