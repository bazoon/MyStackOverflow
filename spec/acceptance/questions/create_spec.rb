require_relative '../acceptance_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask the question
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user create the question' do
    sign_in(user)

    visit '/questions'
    click_on t('ask_question')
    fill_in t('questions.title'), with: 'Test question'
    fill_in t('questions.body'), with: 'text text text'
    click_on t('save')
    expect(page).to have_content t('created')
    expect(page).to have_content 'text text text'
    expect(page).to have_content 'Test question'

  end

  scenario 'Non-authenticated user try to create question' do
    visit '/questions'
    expect(page).to_not have_content t('ask_question')
  end

  
end