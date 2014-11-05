require_relative "../../acceptance_helper"

feature 'Update comment', %q{
  In order to change my comment
  As an authenticated user
  I want to be able to update it
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  # given!(:answer) { create(:answer, body: 'SOOOOM', question_id: question.id) }
  given!(:comment) { create(:question_comment, commentable_id: question.id, user_id: user.id) }
  scenario 'Authenticated user updates a comment for question', js: true do
    sign_in(user)
    visit question_path(question)
    
    
    within(".question .comments") do
      click_link "edit_comment_#{comment.id}"

      fill_in 'Update comment', with: 'COOL COMMENT2'
      click_on 'submit'
      # puts page.driver.console_messages
      # binding.pry
    end
    # save_and_open_page
    # visit question_path(question)
    # page.save_screenshot('/Users/vitaliynesterenko/projects/so/tmp/screenshot.png')
    
    expect(page).to have_content 'COOL COMMENT2'
    
  end

  scenario 'Authenticated user updates a comment with empty body', js: true do
    sign_in(user)
    visit question_path(question)
    click_link "edit_comment_#{comment.id}"
    fill_in t('update_comment'), with: ''
    click_on 'submit'
    expect(page).to have_content "can't be blank"
  end


  scenario 'Non-authenticated user try to update comment for question' do
    visit question_path(question)
    expect(page).to_not have_link "edit_comment_#{comment.id}"
  end



  
end