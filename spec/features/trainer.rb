require 'capybara/rspec'

Capybara.describe 'card trainer feature spec', type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:deck) { FactoryGirl.create(:deck, user: user) }
  let(:card) { FactoryGirl.create(:card, deck: deck, user: user) }

  before :example do
    card.set_test_review_date!

    # Begin login block
    visit root_path
    fill_in 'email', with: card.user.email
    fill_in 'password', with: '123456'
    click_button 'Login'
    # End login block
  end

  it 'checks if the user can do the card quiz correctly' do
    visit root_path
    fill_in 'response', with: 'привет'
    click_button 'Check'
    expect(page).to have_content 'Верно!'
  end

  it 'checks if the user can do the card quiz incorrectly' do
    visit root_path
    fill_in 'response', with: 'не знаю'
    click_button 'Check'
    expect(page).to have_content "Неверно, надо 'привет'"
  end
end
