require 'rails_helper'
require 'spec_helper'

feature 'Signin in', %q{
  In order to be able to ask questions
  As an registered user
  I want to be able to sign_in
}  do

  given(:user) { create(:user) }
  
  scenario 'Existing user tries to sign in' do
    sign_in(user)
    expect(page).to have_content t('devise.sessions.signed_in')
  end

  scenario 'Non-existing user tries to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'somebody@nowhere.com'
    fill_in 'Password', with: '12345'
    click_on 'Sign in'
    expect(page).to have_content t('devise.failure.not_found_in_database')

  end

  
end