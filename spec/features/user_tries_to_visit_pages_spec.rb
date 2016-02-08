require 'rails_helper'

feature 'User tries to visit sample pages' do
  let!(:spec_user) { create(:active_user) }

  feature 'when signed in' do
    before do
      visit new_user_session_path
      fill_in 'Email',    with: spec_user.email # :active_user factory
      fill_in 'Password', with: attributes_for(:active_user)[:password]
      click_button 'Sign In'
    end

    scenario 'can visit the sample page' do
      visit sample_path
      expect(page).to have_selector('img.kitty-mimimi')
    end

    scenario 'can visit the signed sample page' do
      visit signed_sample_path
      expect(page).to have_selector('img.kitty-react')
    end
  end

  feature 'when not signed in' do
    scenario 'can visit the sample page' do
      visit sample_path
      expect(page).to have_selector('img.kitty-mimimi')
    end

    scenario 'CANT visit the signed sample page' do
      visit signed_sample_path
      expect(page).to have_content('SIGN IN')
    end
  end
end
