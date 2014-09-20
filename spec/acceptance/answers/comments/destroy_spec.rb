require 'rails_helper'

feature 'Destroy comment', %q{
  In order to remove my comment
  As an authenticated user
  I want to be able to destroy it
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, body: 'SOOOOM', question_id: question.id) }
  given!(:comment) { create(:comment, commentable_id: answer.id, user_id: user.id) }

  scenario 'Authenticated user updates a comment for answer'  do
    sign_in(user)
    
    visit question_path(question)
    # save_and_open_page
    click_link "destroy_comment#{comment.id}"
  
    # expect(page).to have_content 'updated comment'
    expect(page).to have_content t('destroyed')
  end

  scenario 'Non-authenticated user try to destroy comment for answer' do
    visit question_path(question)
    expect(page).to_not have_link "destroy_comment#{comment.id}"
  end

end