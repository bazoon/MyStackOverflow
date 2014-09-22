require 'rails_helper'

feature 'Create comment', %q{
  In order to comment sombody's question
  As an authenticated user
  I want to be able to comment an question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user creates a comment', js: true do
    # save_and_open_page
    sign_in(user)

    
    visit question_path(question)
    click_link "comment_question#{question.id}"
    
    fill_in t('write_comment'), with: 'new comment'
    click_on 'submit'
  
    expect(page).to have_content 'new comment'
    expect(page).to have_content "Successfuly created !"
  end

  scenario 'Non-authenticated user try to create comment' do
    visit question_path(question)
    expect(page).to_not have_link "comment_question#{question.id}"
  end



  
end