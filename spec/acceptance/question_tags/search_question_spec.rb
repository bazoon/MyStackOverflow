require_relative '../acceptance_helper'

feature 'Search questions by tag', %q{
  In order to view similar questions
  As a user
  I want to be able to Search questions by tag
} do

  let!(:user) { create(:user) }
  let!(:question) { create(:question, title: 'Q1', user_id: user.id) }
  let!(:question2) { create(:question, title: 'Q2', user_id: user.id) }
  let!(:tag) { create(:tag, name: 'TAG') }
  let!(:tagging) { create(:tagging, tag_id: tag.id, taggable_id: question.id, taggable_type: 'Question') }
  let!(:tagging2) { create(:tagging, tag_id: tag.id, taggable_id: question2.id, taggable_type: 'Question') }


  scenario 'User search by tag' do


    visit question_path(question)

    click_on 'TAG'
    expect(page).to have_content('TAG') 
    expect(page).to have_content('Q1') 
    expect(page).to have_content('Q1')

  end


  
end