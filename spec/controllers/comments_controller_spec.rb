require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  
  let(:question) {  create(:question) }
  let(:answer) { create(:answer, question_id: question.id) }
  let(:other_comment) { create(:comment, commentable: answer) } 
  
  before { request.env['HTTP_REFERER'] = question_path(question) }

  context 'Authorized user' do
    sign_in_user
    let(:comment) { create(:comment, commentable: answer, user_id: @user.id) }

    describe '#POST create' do

      context 'with valids attributes' do

        it 'saves the new comment in the database' do
          expect_to_create({ answer_id: answer.id, comment: attributes_for(:comment), format: :js}, Comment)
        end

        it 'renders create template' do
          post :create, answer_id: answer.id, comment: attributes_for(:comment), format: :js
          expect(response).to render_template :create
        end

        it 'redirects to question show view' do
          post :create, answer_id: answer.id, comment: attributes_for(:comment)
          expect(response).to redirect_to(question)
        end

      end

      context 'with invalid attributes' do
        
        it 'does not save the new comment in the database' do
          expect_to_not_create({ answer_id: answer, comment: { body: nil, commentable_type: 'Answer' }, format: :js}, Comment)
        end

        it 'renders error_form' do
          post :create,  answer_id: answer, comment: { body: nil, commentable_type: 'Answer' }, format: :js
          expect(response).to render_template :error_form
        end


      end

    end

    describe '#PATCH update' do
      
      context 'with valid attributes' do
        
        it 'updates user own comment' do
          patch :update, id: comment.id, comment: { body: 'Hello', commentable_type: 'Answer' }, format: :js
          comment.reload
          expect(comment.body).to eq('Hello')
        end

        it 'renders update template' do
          patch :update, id: comment.id, comment: { body: 'Hello'}, format: :js
          expect(response).to render_template :update

        end

        it 'redirects to question show view' do
          patch :update, id: comment.id, comment: { body: 'Hello', commentable_type: 'Answer' }
          expect(response).to redirect_to(question)
        end
        
      end

      context 'with invalid attributes' do
        
        it 'can not update comment' do
          patch :update, id: comment.id, comment: { body: nil, commentable_type: 'Answer' }, format: :js
          comment.reload
          expect(comment.body).to eq('MyComment')
        end       

        it 'renders update_error_form' do
          patch :update, id: comment.id, comment: { body: nil, commentable_type: 'Answer' }, format: :js
          expect(response).to render_template :update_error_form
        end


      end

    end

    describe '#DELETE destroy' do
      
      it 'deletes the requested comment' do
        expect_to_delete(comment, id: comment, format: :js)
      end

      it 'renders destroy template' do
        delete :destroy, id: comment, format: :js
        expect(response).to render_template :destroy
      end

      it 'redirect to question path' do
        delete :destroy, id: comment
        expect(response).to redirect_to(question)
      end

    end

    context 'Forbidden actions' do

      describe '#PATCH update' do
      
        # it 'can not update other user"s comment' do
        #   patch :update, id: other_comment.id, comment: { body: 'Hello', commentable_type: 'Answer' }, format: :js
        #   comment.reload
        #   expect(comment.body).to eq('MyComment')
        # end

        it 'return 403 if via ajax' do
          # patch :update, id: other_comment.id, comment: { body: 'Hello', commentable_type: 'Answer' }, format: :js
          # expect(response.status).to eq(403)
          expect { patch :update, id: other_comment.id, comment: { body: 'Hello', commentable_type: 'Answer' }, format: :js }.to raise_error(CanCan::AccessDenied)
        end

      end

      describe '#DELETE destroy' do
      
        # it 'can not delete the requested comment' do
        #   expect_to_not_delete(other_comment, id: other_comment, format: :js)
        # end

        it 'return 403 if via ajax' do
          expect { delete :destroy, id: other_comment, format: :js }.to raise_error(CanCan::AccessDenied)
          # expect(response.status).to eq(403)

        end



      end

    end


  end

  context 'Unauthorized user' do
     
    describe '#POST create' do

      it 'It does not save the new comment in the database' do
        expect_to_not_create({ answer_id: answer.id, comment: attributes_for(:comment) }, Comment)
      end

      it 'redirects to sign_in path' do
        post :create, answer_id: answer.id, comment: attributes_for(:comment)
        expect(response).to redirect_to(new_user_session_path)
      end

    end


    describe '#DELETE destroy' do
      
      it 'does not delete requested comment' do
       expect_to_not_delete(other_comment, id: other_comment)
      end

      it 'redirect to question path' do
        delete :destroy, id: other_comment
        expect(response).to redirect_to(new_user_session_path)
      end

    end

  end

  


  




end