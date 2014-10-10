require_relative '../acceptance_helper'

feature 'Update answer', %q{
  In order to change my answer
  As an authenticated user
  I want to be able to update my answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:user_answer) { create(:answer, question: question, user: user ) }
  given!(:answer) { create(:answer, question: question) }

  context 'Authenticated user' do
 
    before do 
      sign_in(user)
      visit question_path(question)
    end 

    context 'with valid data' do


      scenario 'updates his own answer via ajax', js: true do
        click_link "edit_answer_#{user_answer.id}"

        within(".answer[data-id='#{user_answer.id}']") do
          fill_in t('answers.body'), with: 'updated body'
          click_on t('save')
          expect(page).to_not have_content user_answer.body
          expect(page).to have_content 'updated body'
        end

        
        
      end
      
    end

    context 'with invalid data' do
      
      scenario 'updates his own answer via ajax', js: true do
        click_link "edit_answer_#{user_answer.id}"
        
        within(".answer[data-id='#{user_answer.id}']") do
          fill_in t('answers.body'), with: ''
          click_on t('save')
        end
        
        expect(page).to have_content "can't be blank"
      end


    end


    scenario 'tries to update somebody"s answer' do
      expect(page).to_not have_link "edit_answer_#{answer.id}"
    end



  end


 
  

  # scenario 'Non-authenticated user try to update an answer' do
  #   visit question_path(question)
  #   expect(page).to_not have_link('edit_answer_#{user_answer.id}')
  # end

  
end