require 'rails_helper'

feature 'Update answer', %q{
  In order to change my answer
  As an authenticated user
  I want to be able to update my answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:user_answer) { create(:answer, question: question, user: user ) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'Authenticated user updates his own answer' do
    sign_in(user)
    visit question_path(question)
    click_link "edit#{user_answer.id}"
    fill_in t('answers.body'), with: 'updated body'
    click_on t('save')
    expect(page).to have_content t('updated')
    expect(page).to have_content 'updated body'
  end

  scenario 'Authenticated user tries to update somebody"s answer' do
    sign_in(user)
    visit question_path(question)
    expect(page).to_not have_link "edit#{answer.id}"
  end

  scenario 'Non-authenticated user try to update an answer' do
    visit question_path(question)
    expect(page).to_not have_link('edit#{user_answer.id}')
  end

  
end