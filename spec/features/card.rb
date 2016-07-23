require 'capybara/rspec'

Capybara.describe 'card trainer', :type => :feature do
  it 'checks if the user can do the card quiz correctly' do
    visit '/'
    fill_in 'response', :with => 'привет'
    click_button 'Проверить'
    expect(page).to have_content 'Верно!'
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
