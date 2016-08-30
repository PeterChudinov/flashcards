require 'rails_helper'

RSpec.describe Deck, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:deck) { FactoryGirl.create(:deck, user: user) }
  let(:card) { FactoryGirl.create(:card, deck: deck, user: user) }

  before :example do
    card.set_test_review_date!
  end

  it 'creates a valid instance' do
    expect { expect(deck.name).to eq('test deck') }
  end

  describe '#get_review_card' do
    context 'checks if it returns a valid card' do
      specify { expect(deck.get_review_card.original_text).to eq('привет') }
    end
  end
end
