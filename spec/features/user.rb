require 'capybara/rspec'

Capybara.describe 'user sign up', :type => :feature do
  before :example do
    @user = FactoryGirl.create(:user)
  end

  it 'checks if user can sign up' do
    visit root_path
    click_link 'Регистрация'
    fill_in 'user_email', with: 'test.test@example.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_button 'Create User'
    expect(page).to have_content 'Регистрация успешна!'
  end

  it 'checks if user can update their password' do
    # begin login block
    visit root_path
    fill_in 'email', with: 'first.last@example.com'
    fill_in 'password', with: '123456'
    click_button 'Login'
    # end login block

    click_link 'first.last@example.com'
    click_link 'Изменить профиль'
    fill_in 'user_password', with: 'MyN3wP4$$wd'
    fill_in 'user_password_confirmation', with: 'MyN3wP4$$wd'
    click_button 'Update User'

    expect(page).to have_content 'Профиль успешно обновлен'
    click_link 'Выйти'
    
    visit root_path
    fill_in 'email', with: 'first.last@example.com'
    fill_in 'password', with: 'MyN3wP4$$wd'
    click_button 'Login'
    expect(page).to have_content 'Вы вошли как first.last@example.com'
  end
end
