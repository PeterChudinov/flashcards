require 'capybara/rspec'

Capybara.describe 'card trainer', :type => :feature do
  let(:user) { FactoryGirl.create(:user) }

  before :example do
    @card = FactoryGirl.create(:card, user: user)
    @card.set_test_review_date!
  end
  
  it 'checks if the user can do the card quiz correctly' do
    visit root_path

    # Begin login block
    fill_in 'email', :with => 'first.last@example.com'
    fill_in 'password', :with => '123456'
    click_button 'Login'
    # End login block

    fill_in 'response', :with => 'привет'
    click_button 'Проверить'
    expect(page).to have_content 'Верно!'
    pending("add capybara-rspec integration")
  end

  it 'checks if the user can do the card quiz incorrectly' do
    visit root_path

    # Begin login block
    fill_in 'email', :with => 'first.last@example.com'
    fill_in 'password', :with => '123456'
    click_button 'Login'
    # End login block

    fill_in 'response', :with => 'не знаю'
    click_button 'Проверить'
    expect(page).to have_content "Неверно, надо 'привет'"
    pending("add capybara-rspec integration")
  end
end
