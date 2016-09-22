require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:user)                          { FactoryGirl.create(:user)             }
  let(:card)                          { FactoryGirl.create(:card, user: user) }
  let(:updated_failed_attempts_count) { card.failed_attempts_count + 1        }
  let(:updated_stage)                 { card.stage + 1                        }

  before :example do
    @card = card

    # touch_review_date! needs that to pass the test
    @card.review_date = 4.days.from_now
    updated_failed_attempts_count = card.failed_attempts_count + 1
    updated_stage = card.stage + 1
  end

  it 'creates a valid instance' do
    expect { expect(@card.original_text).to eq('привет')  }
    expect { expect(@card.translated_text).to eq('hi')    }
  end

  describe '#check_answer?' do
    context 'if the answer is wrong' do
      it 'updates the failed_attempts_count' do
        expect { @card.check_answer?('poka') }.to change { @card.failed_attempts_count }.to updated_failed_attempts_count
      end

      it 'returns false' do
        expect { expect(@card.check_answer?('poka')).to eq(false)  }
      end
    end

    context 'if the answer is right' do
      it 'returns true' do
        expect { expect(@card.check_answer?('привет')).to eq(true) }
      end
    end
  end

  describe '#touch_review_date!' do
    it 'should set review date according to stage' do
      expect { @card.touch_review_date! }.to change { @card.review_date }.to @card.stage_review_date
      expect { @card.touch_review_date! }.to change { @card.stage       }.to updated_stage
    end
  end

  describe '#set_test_review_date!' do
    it 'should set review date to 5 days ago' do
      expect { @card.set_test_review_date! }.to change { @card.review_date }.to 5.days.ago.end_of_day.to_date 
    end
  end

  describe '#stage_review_date' do
    it 'should return the review date according to stage' do
      Timecop.freeze(Time.now)
      case card.stage
      when 0
        expect { expect(@card.stage_review_date).to eq(Date.today.beginning_of_day) }
      when 1
        expect { expect(@card.stage_review_date).to eq(12.hours.from_now)           }
      when 2
        expect { expect(@card.stage_review_date).to eq(3.days.from_now.end_of_day)  }
      when 3
        expect { expect(@card.stage_review_date).to eq(1.week.from_now.end_of_day)  }
      when 4
        expect { expect(@card.stage_review_date).to eq(2.weeks.from_now.end_of_day) }
      when 5
        expect { expect(@card.stage_review_date).to eq(1.month.from_now.end_of_day) }
      end
    end
  end
end
