require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:attributes) { attributes_for(:answer) } 
  let(:question) {  create(:question) }
  let(:some_answer) { create(:answer, question_id: question.id) }
  
  context 'Unauthorized user' do

    describe 'POST #create' do
      
      it 'does not save answer to database' do
        expect { post :create, answer: attributes_for(:answer), question_id: question.id }.to change(Answer, :count).by(0)
      end

      it 'redirects to sign_in path' do
        post :create, answer: attributes_for(:answer), question_id: question.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PATCH #update' do
      
      it 'does not change answer attributes' do
        patch :update, id: some_answer.id, answer: { body: 'new body' }
        some_answer.reload
        expect(some_answer.body).to eq 'MyText'
      end

      it 'redirects to sign_in path' do
        patch :update, id: some_answer, answer: attributes_for(:answer)
        expect(response).to redirect_to(new_user_session_path)
      end

    end

    describe 'DELETE #destroy' do
      
      it 'does not delete requested answer' do
        some_answer
        expect { delete :destroy, id: some_answer }.to change(Answer, :count).by(0)
      end

      it 'redirects to sign_in path' do
        some_answer
        delete :destroy, id: some_answer
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PATCH #select' do
        
      it 'can not select a question' do
        patch :select, id: some_answer.id
        expect(some_answer.selected).to eq(false)
      end

      it 'redirects to sign_in path' do
        patch :select, id: some_answer.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'Authorized user' do

    sign_in_user  

    let(:answer) { create(:answer, user_id: @user.id) }

    

    describe 'POST #create' do
      

      context 'with valids attributes' do

        it 'saves the new answer in the database' do
          expect_to_create({ answer: attributes_for(:answer), question_id: question }, Answer)
        end

        it 'redirects to question show view' do
          post :create, answer: attributes_for(:answer), question_id: question
          expect(response).to redirect_to assigns(:question)
        end

      end

      context 'with invalid attributes' do
        it 'does not save the answer' do
          expect_to_not_create({ answer: attributes_for(:invalid_answer), question_id: question }, Answer)
        end

        it 're-renders question view' do
          post :create, answer: attributes_for(:invalid_question), question_id: question  
          expect(response).to redirect_to question
        end
      end
    end

    describe 'PATCH #update' do
      
      context 'user updates his own answer' do

        context 'valid attributes' do

          it 'asssign the requested anser to @answer' do
            patch :update, id: answer, answer: attributes_for(:answer)
            expect(assigns(:answer)).to eq answer
          end
        
          it 'changes answer attributes' do
            patch :update, id: answer, answer: { body: 'new body' }
            answer.reload
            expect(answer.body).to eq 'new body'
          end

          it 'redirects to updated answer' do
            patch :update, id: answer, answer: attributes_for(:answer)
            expect(response).to redirect_to answer.question
          end
        end

        context 'invalid attributes' do
          before { patch :update, id: answer, answer: { body: nil, user_id: nil } }

          it 'does not change answer attributes' do
            expect(answer.body).to eq 'MyText'
          end

          it 're-render edit view' do
            expect(response).to render_template :edit
          end

        end
      end

    end

    describe 'PATCH #select' do
        
      context "User selects answer for his question" do
        let(:user_question) { create(:question, user_id: @user.id) }
        let(:question_answer) { create(:answer, question_id: user_question.id) }

        it 'question author can select a question' do
          patch :select, id: question_answer
          question_answer.reload
          expect(question_answer.selected).to eq(true)
        end

        it 'redirects to question path' do
          patch :select, id: question_answer.id
          expect(response).to redirect_to user_question
        end
      end

    end

    describe 'DELETE #destroy' do

      context 'User deletes his own question' do

        it 'deletes requested answer' do
          answer
          expect { delete :destroy, id: answer }.to change(Answer, :count).by(-1)
        end

        it 'redirects to question view' do
          question = answer.question
          delete :destroy, id: answer
          expect(response).to redirect_to question
        end
      end

      
    end

    context 'Forbiden actions' do
      
      describe 'DELETE #destroy' do
        it 'can not delete other user answer' do
          expect_to_not_delete(some_answer, id: some_answer)
        end

        it 'tries to delete other user answer' do
          delete :destroy, id: some_answer
          expect(response).to redirect_to(root_path)
        end

      end

      describe 'PATCH #updated' do
        
        it 'can not update other user answer' do
          patch :update, id: some_answer, answer: { body: 'new body' }
          some_answer.reload
          expect(some_answer.body).to eq attributes[:body]
        end

        it 'tries to update some user answer' do
          patch :update, id: some_answer, answer: attributes_for(:answer)
          expect(response).to redirect_to(root_path)  
        end

      end


      describe 'PATCH #select' do

        it 'question author can select a question' do
          patch :select, id: answer
          answer.reload
          expect(answer.selected).to eq(false)
        end
        
      end


    end

  end
end
