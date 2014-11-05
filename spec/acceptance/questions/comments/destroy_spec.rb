require_relative "../../acceptance_helper"

feature 'Destroy comment', %q{
  In order to remove my comment
  As an authenticated user
  I want to be able to destroy it
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, body: 'SOOOOM', question_id: question.id) }
  given!(:comment) { create(:question_comment, commentable_id: question.id, user_id: user.id) }

  scenario 'Authenticated user destroys comment for question', js: true do
    sign_in(user)
    # binding.pry
    comment
    visit question_path(question)
    click_link "destroy_comment#{comment.id}"
    
    # page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content(comment.body)
  end

  scenario 'Non-authenticated user try to destroy comment for question', js: true do
    visit question_path(question)
    expect(page).to_not have_link "destroy_comment#{comment.id}"
  end

end
