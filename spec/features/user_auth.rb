require 'capybara/rspec'

Capybara.describe 'user sign up', :type => :feature do
  before :example do
    @user = FactoryGirl.create(:user)
  end

  # TODO: get rid of the login block

  it 'checks if user can sign in' do
    # begin login block
    visit root_path
    fill_in 'email', with: 'first.last@example.com'
    fill_in 'password', with: '123456'
    click_button 'Login'
    # end login block

    expect(page).to have_content 'Вы вошли как first.last@example.com'
  end

  it 'checks if user can logout' do
    # begin login block
    visit root_path
    fill_in 'email', with: 'first.last@example.com'
    fill_in 'password', with: '123456'
    click_button 'Login'
    # end login block

    click_link 'Выйти'
    expect(page).to have_content 'Вы успешно вышли'
  end
end
