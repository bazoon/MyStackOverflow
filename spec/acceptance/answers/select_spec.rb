require 'rails_helper'

feature 'Select answer', %q{
  In order to pick best answer 
  As the question author
  I want to be able to select an answer for my a question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, selected: false) }
  given!(:selected_answer) { create(:answer, question: question, selected: true) }

  before do
    sign_in(user)
    visit question_path(question)
  end

    
  scenario 'Question author can select best question', format: :js do
    click_on "select#{answer.id}"
    expect(find("#answer_#{answer.id}")).to have_css('div.selected-answer')
  end

  scenario 'If Question selects one question the previous should be deselected', format: :js do
    
    expect(find("#answer_#{selected_answer.id}")).to have_css('div.selected-answer')      
    expect(find("#answer_#{answer.id}")).to_not have_css('div.selected-answer')      
    
    click_on "select#{answer.id}"

    expect(find("#answer_#{answer.id}")).to have_css('div.selected-answer')      
    expect(find("#answer_#{selected_answer.id}")).to_not have_css('div.selected-answer')      
  end


end
