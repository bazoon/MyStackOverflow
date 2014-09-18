require 'rails_helper'

feature 'Create question', %q{
  In order to remove unneeded question from site
  As an authenticated user
  I want to be able to destroy it
} do

  given(:user) { create(:user) }
  given!(:user_question) { create(:question, user: user) }

  scenario 'Authenticated user destroys his own question' do
    sign_in(user)
    visit '/questions'
    click_link "delete#{user_question.id}"
    expect(page).to have_content t('destroyed')
  end

  scenario 'Non-authenticated user try to destroy question' do
    visit '/questions'
    expect(page).to_not have_link "delete#{user_question.id}"
  end

  
end