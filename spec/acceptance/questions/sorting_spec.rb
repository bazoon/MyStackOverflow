require_relative '../acceptance_helper'

feature 'Question ordering', %q{
  In order to view questions in different
  orders
  I want to be able to sort them
} do

  given!(:user) { create(:user) }
  
  given!(:older_question) { create(:question, title: 'OLD', rating: 1, created_at: 25.days.ago) }
  given!(:question) { create(:question, title: 'NEW', rating: 2, created_at: 3.days.ago) }
  
  given!(:answers) { create_list(:answer, 2, question: question) }
  given!(:old_answers) { create_list(:answer, 1, question: older_question) }



  scenario 'Questions should be ordered by created_at desc initialy' do
    visit '/questions'
    expect(question.title).to appear_before(older_question.title)
  end

  scenario 'User view questions for last week' do
    visit '/questions'
    within '.questions_order' do
      click_link 'week'
    end
    expect(page).to have_content(question.title) 
    expect(page).to_not have_content(older_question.title) 
  end

   scenario 'User view questions for last week' do
    visit '/questions'
    within '.questions_order' do
      click_link 'month'
    end
    expect(page).to have_content(question.title) 
    expect(page).to have_content(older_question.title) 
  end

  scenario 'User orders questions by answers count - hot' do
    visit '/questions'
    within '.questions_order' do
      click_link 'hot'
    end
    expect(question.title).to appear_before(older_question.title)
  end

  scenario 'User orders questions by rating - featured' do
    
    visit '/questions'
    within '.questions_order' do
      click_link 'featured'
    end
    expect(question.title).to appear_before(older_question.title)
  end

  scenario 'User orders questions by views - interesting' do
    sign_in(user)
    visit question_path(older_question)
    
    visit '/questions'
    within '.questions_order' do
      click_link 'interesting'
    end
    expect(older_question.title).to appear_before(question.title)
  end


  
end
