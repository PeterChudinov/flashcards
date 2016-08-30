require 'capybara/rspec'

# move and rename
Capybara.describe 'card trainer', :type => :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:deck) { FactoryGirl.create(:deck, user: user) }
  let(:card) { FactoryGirl.create(:card, deck: deck, user: user) }

  before :example do
    deck = card.deck
    deck.cards.each do |c|
      c.set_test_review_date!
    end

    # Begin login block
    visit root_path
    fill_in 'email', with: card.user.email
    fill_in 'password', with: '123456'
    click_button 'Login'
    # End login block
  end
  
  it 'checks if user can create a card' do
    visit root_path
    click_link 'New deck'
    fill_in 'deck_name', with: 'test deck'
    click_button 'Create deck'
    click_link 'New Card'
    fill_in 'card_original_text', with: 'hund'
    fill_in 'card_translated_text', with: 'dog'
    attach_file 'card_image', "#{Rails.root}/spec/fixtures/dog.jpg"
    click_button 'Create card'
    expect(page).to have_content 'hund'
  end
end
