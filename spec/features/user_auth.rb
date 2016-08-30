require 'capybara/rspec'

Capybara.describe 'user sign up', :type => :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:deck) { FactoryGirl.create(:deck, user: user) }
  let(:card) { FactoryGirl.create(:card, deck: deck, user: user) }

  # TODO: get rid of the login block

  it 'checks if user can sign in' do
    # begin login block
    visit root_path
    fill_in 'email', with: user.email
    fill_in 'password', with: '123456'
    click_button 'Login'
    # end login block

    expect(page).to have_content 'LOCALE_LOG_IN_SUCCESS'
  end

  it 'checks if user can logout' do
    # begin login block
    visit root_path
    fill_in 'email', with: user.email
    fill_in 'password', with: '123456'
    click_button 'Login'
    # end login block

    click_link 'Log out'
    expect(page).to have_content 'Вы успешно вышли'
  end

  it "checks if user can't login if the password is wrong" do
    # begin login block
    visit root_path
    fill_in 'email', with: user.email
    fill_in 'password', with: '123456x'
    click_button 'Login'
    # end login block

    expect(page).to have_content 'Логин или пароль неверны'
  end
end
