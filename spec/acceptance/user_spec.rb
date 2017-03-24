require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to work with recipe
  As an User
  I want to be able to sign in
} do

  scenario 'Registered user tryes to sign in' do
    user = User.create!(email: 'test@test.test', password: 'password')
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Not-registered user tryes to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'tt@tt.t'
    fill_in 'Password', with: 'adfgsdfa'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end

end
