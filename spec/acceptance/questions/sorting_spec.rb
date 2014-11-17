require_relative '../acceptance_helper'

feature 'Question ordering', %q{
  In order to view questions in different
  orders
  I want to be able to sort them
} do

  given!(:user) { create(:user) }
  given!(:older_question) { create(:question, title: 'OLD', rating: 1) }
  given!(:question) { create(:question, title: 'NEW', rating: 2) }
  
  given!(:answers) { create_list(:answer, 2, question: question) }
  given!(:old_answers) { create_list(:answer, 1, question: older_question) }

  scenario 'Questions should be ordered by created_at desc initialy' do
    visit '/questions'
    expect(question.title).to appear_before(older_question.title)
  end

  scenario 'User orders questions by creation date' do
    visit '/questions'
    within '.questions_order' do
      click_link 'Added'
    end
    expect(older_question.title).to appear_before(question.title)
  end

  scenario 'User orders questions by answers count' do
    visit '/questions'
    within '.questions_order' do
      click_link 'Answers'
    end
    expect(older_question.title).to appear_before(question.title)
  end

  scenario 'User orders questions by votes' do
    
    visit '/questions'
    within '.questions_order' do
      click_link 'Votes'
    end
    expect(older_question.title).to appear_before(question.title)
  end

  scenario 'User orders questions by views' do
    sign_in(user)
    visit question_path(older_question)
    visit '/questions'
    within '.questions_order' do
      click_link 'Views'
    end
    expect(older_question.title).to appear_before(question.title)
  end


  
end
