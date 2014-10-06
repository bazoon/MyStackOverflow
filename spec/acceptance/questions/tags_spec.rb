require_relative '../acceptance_helper'

feature 'Tag question', %q{
  In order to mark my question with tags
  As an authenticated user
  I want to be able to tag a question
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user marks a question with tags' do
    sign_in(user)

    
    click_on t('ask_question')
    fill_in t('questions.title'), with: 'Test question'
    fill_in t('questions.body'), with: 'text text text'
    fill_in t('questions.tags'), with: 'one, two, three'
    click_on t('save')
    expect(page).to have_content 'one,two,three'
  end

  
  
end