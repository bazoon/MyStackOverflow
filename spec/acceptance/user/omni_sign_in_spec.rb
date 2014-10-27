require_relative '../acceptance_helper'

feature 'User sign in with Twitter or Facebook', %q{
  In order to be able to ask questions
  As an User
  I want to be able to sign in with Twitter or Facebook
} do


  scenario 'Non-registered user tries to sign in with Facebook' do
    visit new_user_session_path
    expect(page).to have_content 'Sign in with Facebook'
    set_mock_hash_for_facebook
    click_link "Sign in with Facebook"
    expect(page).to have_content 'Successfully authenticated from facebook account.'
    expect(page).to have_link 'Sign out'
  end

  scenario "User failed to authenticate himself via Facebook" do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit new_user_session_path
    expect(page).to have_content 'Sign in with Facebook'
    click_link "Sign in with Facebook"
    expect(page).to have_link 'Sign in'
    expect(page).to have_content "Could not authenticate you from Facebook"
  end

  scenario 'Non-registered user try to sign in with Twitter' do
    visit new_user_session_path
    expect(page).to have_content 'Sign in with Twitter'
    set_mock_hash_for_twitter
    click_link 'Sign in with Twitter'
    expect(page).to have_content 'Enter your email please'
    fill_in 'Email', with: 'foo@example.com'
    click_on 'Confirm'
    expect(page).to have_content 'Confirmation hase been sent'
  end
 

  scenario "Non-authenticated if error with twitter oauth" do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    visit new_user_session_path
    expect(page).to have_content 'Sign in with Twitter'
    click_link "Sign in with Twitter"
    expect(page).to have_link 'Sign in'
    expect(page).to have_content "Could not authenticate you from Twitter"
  end







end