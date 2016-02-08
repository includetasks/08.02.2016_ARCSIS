require 'rails_helper'

feature 'User tries to create a user' do
  scenario 'and DONE with valid input' do
    first_count = User.count

    visit new_user_path

    fill_in 'First name', with: 'Test'
    fill_in 'Last name',  with: 'Test'
    fill_in 'Phone',      with: '999-000-123'
    fill_in 'Email',      with: 'blabluble@ata.tu'
    fill_in 'Password',   with: 'chachacha123___'

    click_button 'Create'
    expect( User.count - first_count ).to eq(1)
  end

  scenario 'and FAILS with invalid input' do
    first_count = User.count

    visit new_user_path
    
    click_button 'Create'
    expect( User.count - first_count ).to eq(0)
  end
end
