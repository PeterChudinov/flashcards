require 'capybara/rspec'

Capybara.describe 'card trainer', :type => :feature do
  before :each do
    Card.create(:original_text => 'привет', :translated_text => 'hi', :review_date => '2015-02-03')
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

=begin
describe "the signin process", :type => :feature do
  before :each do
    User.make(:email => 'user@example.com', :password => 'password')
  end

  it "signs me in" do
    visit '/sessions/new'
    within("#session") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'Sign in'
    expect(page).to have_content 'Success'
  end
end
=end
