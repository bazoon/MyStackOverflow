require 'rails_helper'

feature 'Update comment', %q{
  In order to change my comment
  As an authenticated user
  I want to be able to update it
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, body: 'SOOOOM', question_id: question.id) }
  given!(:comment) { create(:question_comment, commentable_id: question.id, user_id: user.id) }

  scenario 'Authenticated user updates a comment for question', js: true do
    sign_in(user)
    visit question_path(question)
    click_link "edit_comment#{comment.id}"
    fill_in t('update_comment'), with: 'updated comment'
    click_on 'submit'
    expect(page).to have_content 'updated comment'
    expect(page).to have_content t('updated')
  end

  scenario 'Non-authenticated user try to update comment for question' do
    visit question_path(question)
    expect(page).to_not have_link "edit_comment#{comment.id}"
  end



  
end