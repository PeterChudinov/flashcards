class Card < ApplicationRecord
  belongs_to :user
  belongs_to :deck
  delegate :user, to: :deck

  has_attached_file :image, styles: { medium: "300x300#", thumb: "20x20#" }
  validates_attachment :image,
    content_type: {
      content_type: ["image/jpeg", "image/gif", "image/png"]
    }

  before_validation(on: :create) do
    self.user = self.deck.user
    self.review_date = 3.days.from_now.end_of_day
  end

  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validates :stage, inclusion: 0..5, presence: true
  validates :failed_attempts_count, inclusion: 0..3

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
    self.where(["review_date <= ?", Date.today]).sample
  end

  def check_answer?(response)
    result = UnicodeUtils::downcase(response).strip == UnicodeUtils::downcase(original_text).strip
    unless result
      update_column(:failed_attempts_count, failed_attempts_count + 1)
      if failed_attempts_count == 3
        update_column(:failed_attempts_count, 0)
        update_column(:stage, 0)
      end
    end
    return result
  end

  def stage_review_date
    case stage
    when 0
      Date.today.beginning_of_day
    when 1
      12.hours.from_now
    when 2
      3.days.from_now.end_of_day
    when 3
      1.week.from_now.end_of_day
    when 4
      2.weeks.from_now.end_of_day
    when 5
      1.month.from_now.end_of_day
    end
  end

  def touch_review_date!
    update_columns(review_date: stage_review_date, stage: stage + 1) if stage < 5
  end

  # For testing purpouses only
  def set_test_review_date!
    update_column(:review_date, 5.days.ago.end_of_day)
  end
end

