Capybara.describe 'deck management', type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  before :example do
    @deck = FactoryGirl.create(:deck, user: user)

    # begin login block
    visit root_path
    fill_in 'email', with: user.email
    fill_in 'password', with: '123456'
    click_button 'Login'
    expect(page).to have_content 'LOCALE_LOG_IN_SUCCESS'
    # end login block
  end

  it 'checks if user can set deck as current' do
    click_link 'Decks'
    click_link 'LOCALE_SET_CURRENT_DECK'
    expect(page).to have_content "LOCALE_CURRENT_DECK_SET_TO '#{@deck.name}'"
  end

  it 'checks if user can delete a deck' do
    click_link 'Decks'
    click_link 'Delete'
    expect(page).to have_content 'LOCALE_DECK_DELETED'
  end
end
