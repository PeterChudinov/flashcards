require 'capybara/rspec'

Capybara.describe 'card trainer', :type => :feature do
  let(:user) { FactoryGirl.create(:user) }

  before :example do
    @deck = FactoryGirl.build(:deck_with_cards)
    @deck.user_id = user.id
    @deck.save!
    @deck.cards.each do |c|
      c.set_test_review_date!
    end
    user.current_deck_id = @deck.id

    # Begin login block
    visit root_path
    fill_in 'email', with: 'first.last@example.com'
    fill_in 'password', with: '123456'
    click_button 'Login'
    # End login block
  end
  
  it 'checks if user can create a card' do
    visit root_path
    click_link 'Add a card'
    fill_in 'deck_card_original_text', with: 'hund'
    fill_in 'deck_card_translated_text', with: 'dog'
    attach_file 'deck_card_image', "#{Rails.root}/spec/fixtures/dog.jpg"
    click_button 'Create card'
    expect(page).to have_content 'hund'
  end
end
