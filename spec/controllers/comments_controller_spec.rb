require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:current_user) { create(:user) } 
  let(:question) {  create(:question) }
  let(:answer) { create(:answer, question_id: question.id) }
  
  before { request.env['HTTP_REFERER'] = question_path(question) }

  context 'Authorized user' do
    sign_in_user
    
    describe '#POST create' do

      before { request.env['HTTP_REFERER'] = question_path(question) }

      context 'with valids attributes' do

        it 'saves the new comment in the database' do
          expect { post :create, answer_id: answer.id, comment: attributes_for(:comment) }.to change(Comment, :count).by(1)
        end

        it 'redirects to question show view' do
          post :create, answer_id: answer.id, comment: attributes_for(:comment)
          expect(response).to redirect_to question_path(question)
        end

      end
      

      context 'with invalid attributes' do
        
        it 'does not save the new comment in the database' do
          expect { post :create, answer_id: answer.id, comment: { body: nil, commentable_type: 'Answer' } }.to change(Comment, :count).by(0)
        end

      end

    end

    describe '#PATCH update' do
      
      let(:comment) { create(:comment, commentable: answer, user_id: current_user.id) }
      let(:other_comment) { create(:comment, commentable: answer) } 

      context 'with valid attributes' do
        
        it 'updates user own comment' do
          patch :update, id: comment.id, comment: { body: 'Hello', commentable_type: 'Answer' }
          comment.reload
          expect(comment.body).to eq('Hello')
        end

        it 'redirects to question show view' do
            patch :update, id: comment.id, comment: { body: 'Hello', commentable_type: 'Answer' }
          expect(response).to redirect_to question_path(question)
        end

        it 'can not update other user"s comment' do
          patch :update, id: other_comment.id, comment: { body: 'Hello', commentable_type: 'Answer' }
          comment.reload
          expect(comment.body).to eq('MyText')
        end

        
      end

      context 'with invalid attributes' do
        
        it 'can not update comment' do
          patch :update, id: comment.id, comment: { body: nil, commentable_type: 'Answer' }
          comment.reload
          expect(comment.body).to eq('MyText')
        end       

      end

    end








  end






end