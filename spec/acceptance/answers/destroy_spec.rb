require 'rails_helper'

feature 'Destroy answer', %q{
  In order to remove my answer
  As an authenticated user
  I want to be able to destroy my answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:user_answer) { create(:answer, question: question, user: user ) }
  given!(:answer) { create(:answer, question: question, body: "Answer") }

  scenario 'Authenticated user destroys his own answer' do
    sign_in(user)
    visit question_path(question)
    click_link "delete#{user_answer.id}"
    expect(page).to_not have_content 'MyText'
    expect(page).to_not have_link "delete#{user_answer.id}"
  end

  scenario 'Authenticated user tries to destroy sombody"s answer' do
    sign_in(user)
    visit question_path(question)
    expect(page).to_not have_link "delete#{answer.id}"
  end

  scenario 'Non-authenticated user try to update an answer' do
    visit question_path(question)
    expect(page).to_not have_link('delete#{user_answer.id}')
  end

  
end