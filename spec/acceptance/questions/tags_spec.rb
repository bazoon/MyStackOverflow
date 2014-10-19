require_relative '../acceptance_helper'

feature 'Tag question', %q{
  In order to mark my question with tags
  As an authenticated user
  I want to be able to tag a question
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, body: 'BODY', user_id: user.id) }
  given!(:tag) { create(:tag, name: 'TAG') }
  given!(:tagging) { create(:tagging, tag_id: tag.id, taggable_id: question.id, taggable_type: 'Question') }
  

  before { sign_in(user) }

  scenario 'Authenticated user marks a question with tags' do
    
    click_on t('ask_question')
    fill_in t('questions.title'), with: 'Test question'
    fill_in t('questions.body'), with: 'text text text'
    fill_in t('questions.tag_tokens'), with: 'one, two, three'
    click_on t('save')
    expect(page).to have_link('one')
    expect(page).to have_link('two')
    expect(page).to have_link('three')

  end

  scenario 'Authenticated update question with other tags' do
    visit question_path(question)
    
    expect(page).to have_link 'TAG'
    click_link "edit_question_#{question.id}"
    fill_in t('questions.tag_tokens'), with: 'one, two, three'
    click_on t('save')
    expect(page).to have_link('one')
    expect(page).to have_link('two')
    expect(page).to have_link('three')
    expect(page).to_not have_link('TAG')
    
  end
  


  
end