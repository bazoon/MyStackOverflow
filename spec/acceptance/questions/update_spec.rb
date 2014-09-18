require 'rails_helper'

feature 'Update question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to update my question
} do

  given(:user) { create(:user) }
  given(:user_question) { create(:question, user: user) }
  given(:question) { create (:question) }

  scenario 'Authenticated user update his own the question' do
    sign_in(user)
    visit edit_question_path(user_question)
    fill_in t('questions.title'), with: 'updated title'
    fill_in t('questions.body'), with: 'updated body'
    click_on t('save')
    

    expect(page).to have_content t('updated')
    expect(page).to have_content 'updated title' #create also!
    expect(page).to have_content 'updated body'
  end

  scenario 'Authenticated user try to update somebody"s question' do
    sign_in(user) #не видит ссылки
    visit edit_question_path(user_question)
    expect(page).to_not have_field('questions.title')
    expect(page).to_not have_field('questions.body')
  end

  scenario 'Non-authenticated user try to update question' do
    visit edit_question_path(user_question)
    expect(page).to_not have_field('questions.title')
    expect(page).to_not have_field('questions.body')
  end

  
  
end