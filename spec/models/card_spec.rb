require 'rails_helper'

RSpec.describe Card, type: :model do

  before do
    @card = Card.create(:original_text => ' привет', :translated_text => 'HI ')
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
    it 'should set review date to 3 days ahead' do
     expect { @card.touch_review_date! }.to change{ @card.review_date }.to(Date.today + 3.days)
    end
  end
end
