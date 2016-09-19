require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  before :example do
    @card = FactoryGirl.create(:card, user: user)

    # touch_review_date! needs that to pass the test
    @card.review_date = 4.days.from_now
  end

  it 'creates a valid instance' do
    expect { expect(@card.original_text).to eq('привет') }
    expect { expect(@card.translated_text).to eq('hi') }
  end

  describe '#check_answer?' do
    context 'the answer is right' do
      specify { expect(@card.check_answer?('привет')).to eq(true) }
    end

    context 'the answer is wrong' do
      specify { expect(@card.check_answer?('poka')).to eq(false) }
    end
  end

  describe '#touch_review_date!' do
    it 'should set review date according to stage' do
      expect { @card.touch_review_date! }.to change { @card.review_date }.to @card.stage_review_date
      previous_stage = @card.stage
      expect { @card.touch_review_date! }.to change { @card.stage }.to previous_stage + 1
    end
  end

  describe '#set_test_review_date!' do
    it 'should set review date to 5 days ago' do
      expect { @card.set_test_review_date! }.to change { @card.review_date }.to 5.days.ago.end_of_day.to_date 
    end
  end

  describe '#stage_review_date' do

      # def stage_review_date
      #   case stage
      #   when 0
      #     Date.today.beginning_of_day
      #   when 1
      #     12.hours.from_now
      #   when 2
      #     3.days.from_now.end_of_day
      #   when 3
      #     1.week.from_now.end_of_day
      #   when 4
      #     2.weeks.from_now.end_of_day
      #   when 5
      #     1.month.from_now.end_of_day
      #   end
      # end

      Timecop.freeze(Time.now)
      specify { expect(@card.stage_review_date).to eq(Date.today.beginning_of_day) }
      specify { expect(@card.stage_review_date).to eq(12.hours.from_now) }
      specify { expect(@card.stage_review_date).to eq(3.days.from_now.end_of_day) }
      specify { expect(@card.stage_review_date).to eq(1.week.from_now.end_of_day) }
      specify { expect(@card.stage_review_date).to eq(2.weeks.from_now.end_of_day) }
      specify { expect(@card.stage_review_date).to eq(1.month.from_now.end_of_day) }

  end
end
