require 'capybara/rspec'

Capybara.describe 'user management', type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:deck) { FactoryGirl.create(:deck, user: user) }
  let(:card) { FactoryGirl.create(:card, deck: deck, user: user) }

  it 'checks if user can sign up' do
    visit root_path
    click_link 'Sign up'
    fill_in 'user_email', with: 'test.test@example.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_button 'Create User'
    expect(page).to have_content 'LOCALE_SIGN_UP_SUCCESS'
  end

  describe 'updating profile' do
    before :example do
      # begin login block
      visit root_path
      fill_in 'email', with: user.email
      fill_in 'password', with: '123456'
      click_button 'Login'
      expect(page).to have_content 'LOCALE_LOG_IN_SUCCESS'
      # end login block
    end

    it 'checks if user can update their password' do
      click_link user.email
      click_link 'Update profile'
      fill_in 'user_password', with: 'MyN3wP4$$wd'
      fill_in 'user_password_confirmation', with: 'MyN3wP4$$wd'
      click_button 'Update User'

      expect(page).to have_content 'LOCALE_PROFILE_UPDATE_SUCCESS'
      click_link 'Log out'
      
      visit root_path
      fill_in 'email', with: user.email
      fill_in 'password', with: 'MyN3wP4$$wd'
      click_button 'Login'
      expect(page).to have_content 'LOCALE_LOG_IN_SUCCESS'
    end

    it 'checks if user is returned back if password validation fails' do
      click_link user.email
      click_link 'Update profile'
      fill_in 'user_password', with: '12'
      fill_in 'user_password_confirmation', with: '32'
      click_button 'Update User'
      
      expect(page).to have_content 'LOCALE_PROFILE_UPDATE_FAILURE'
    end
  end
end
