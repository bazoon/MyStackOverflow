require 'rails_helper'

feature 'Create answer', %q{
  In order to answer sombody's question
  As an authenticated user
  I want to be able to answer a question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  context 'with valid atttribues' do

    scenario 'Authenticated user create the answer' do
      sign_in(user)
      visit question_path(question)
      fill_in t('answers.body'), with: 'text text text'
      click_on t('save')
      expect(page).to have_content 'text text text'
    end

    scenario 'Authenticated user create the answer with ajax', js: true do
      sign_in(user)
      visit question_path(question)
      fill_in t('answers.body'), with: 'text text text'
      click_on t('save')
      expect(page).to have_content 'text text text'
    end


  end


  context 'with invalid atttribues' do
    
    scenario 'Authenticated user tries create the answer', js: true do
      sign_in(user)
      visit question_path(question)
      fill_in t('answers.body'), with: ''
      click_on t('save')

      expect(page).to have_content 'Please review the problems below:'
      expect(page).to have_content "can't be blank"
    end

  end

  

  scenario 'Non-authenticated user try to create answer' do
    visit question_path(question)
    expect(page).to_not have_field t('answers.body')
  end



  
end