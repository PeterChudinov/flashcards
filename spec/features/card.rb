require 'capybara/rspec'

Capybara.describe 'card trainer', :type => :feature do

  before do
    @card = FactoryGirl.create(:card)
    @card.set_test_review_date!
  end
  
  it 'checks if the user can do the card quiz correctly' do
    visit root_path
    fill_in 'response', :with => 'привет'
    click_button 'Проверить'
    expect(page).to have_content 'Верно!'
  end

  it 'checks if the user can do the card quiz incorrectly' do
    visit root_path
    fill_in 'response', :with => 'не знаю'
    click_button 'Проверить'
    expect(page).to have_content 'Неверно!'
  end
end
