# require 'rails_helper'

# feature 'Create comment', %q{
#   In order to comment sombody's answer
#   As an authenticated user
#   I want to be able to comment an answer
# } do

#   ['answer', 'question'].each do |commentable|

#     given(:user) { create(:user) }
#     given!(:question) { create(:question) }
#     given!(:answer) { create(:answer, body: 'SOOOOM', question_id: question.id) }

#     scenario "Authenticated user creates a comment for #{commentable}", js: true do
#       sign_in(user)
      
#       visit question_path(question)
#       click_link "comment_#{commentable}#{answer.id}"
      
#       fill_in t('write_comment'), with: 'new comment'
#       click_on 'submit'
    
#       expect(page).to have_content 'new comment'
#       expect(page).to have_content 'Successfuly created !'
#     end

#     scenario 'Non-authenticated user try to create comment for #{commentable}' do
#       visit question_path(question)
#       expect(page).to_not have_link "comment_#{commentable}#{answer.id}"
#     end

  
#   end  


  
# end