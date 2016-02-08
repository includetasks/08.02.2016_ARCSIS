require 'rails_helper'

feature 'User tries to sign in' do
  let!(:spec_active_user)   { create(:active_user) }
  let!(:spec_inactive_user) { create(:inactive_user) }

  feature 'when user is active' do
    scenario 'can to sign in' do
      visit new_user_session_path

      fill_in 'Email',    with: spec_active_user.email
      fill_in 'Password', with: attributes_for(:active_user)[:password]

      click_button 'Sign In'

      expect(page).to have_content('Signed in successfully')
    end
  end

  feature 'when user is not active' do
    scenario 'cant to sign in' do
      visit new_user_session_path

      fill_in 'Email',    with: spec_inactive_user.email
      fill_in 'Password', with: attributes_for(:inactive_user)[:password]

      click_button 'Sign In'

      expect(page).to have_content('You are still not activated')
    end
  end
end
