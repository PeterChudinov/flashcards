require 'rails_helper'

RSpec.configure do |config|
  config.before(:example, deck: nil) do
    user.set_current_deck(nil)
  end
end

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:deck) { FactoryGirl.create(:deck, user: user) }
  let(:card) { FactoryGirl.create(:card, deck: deck, user: user) }

  it 'creates a valid instance' do
    expect { expect(user.email).to eq('first.last@example.com') }
    expect { expect(user.password).to eq('123456') }
  end

  describe '#current_deck_cards' do
    context 'returns deck cards if there is a current deck' do
      specify { expect(user.current_deck_cards).to eq(user.cards) }
    end

    context 'returns all cards if there is no current deck', deck: :nil do
      specify { expect(user.current_deck_cards).to eq(deck.cards) }
    end
  end

  describe '#set_current_deck(id)' do
    context 'sets deck passed in the argument as current' do
      specify { expect(user.set_current_deck(deck.id)).to eq(deck.id) }
      # Should check if user.current_deck_id is equal to deck.id
    end
  end
end
