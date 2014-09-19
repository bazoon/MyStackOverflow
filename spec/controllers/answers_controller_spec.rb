require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) {  create(:question) }
  let(:answer) { create(:answer, question_id: question.id) }
  
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
        patch :update, id: answer, answer: { body: 'new body' }
        answer.reload
        expect(answer.body).to eq 'MyText'
      end

      it 'redirects to sign_in path' do
        patch :update, id: answer, answer: attributes_for(:answer)
        expect(response).to redirect_to(new_user_session_path)
      end

    end


    describe 'DELETE #destroy' do
      
      it 'does not delete requested answer' do
        answer
        expect { delete :destroy, id: answer }.to change(Answer, :count).by(0)
      end

      it 'redirects to sign_in path' do
        answer
        delete :destroy, id: answer
        expect(response).to redirect_to(new_user_session_path)
      end
   
    end


    describe 'PATCH #select' do
        
      it 'can not select a question' do
        patch :select, id: answer.id
        expect(answer.selected).to eq(false)
      end

      it 'redirects to sign_in path' do
        patch :select, id: answer.id
        expect(response).to redirect_to(new_user_session_path)
      end

    end


  end
  



  context 'Authorized user' do

    let(:current_user) { create(:user) }
    let(:user_answer) { create(:answer, user_id: current_user.id) }


    before do
      # allow(controller).to receive(:current_user).and_return current_user
      sign_in(current_user)
    end

    describe 'POST #create' do
      
      context 'with valids attributes' do

        it 'saves the new answer in the database' do
          expect { post :create, answer: attributes_for(:answer), question_id: question.id }.to change(Answer, :count).by(1)
        end

        it 'redirects to question show view' do
          post :create, answer: attributes_for(:answer), question_id: question.id
          expect(response).to redirect_to question_path(assigns(:question))
        end

      end

      context 'with invalid attributes' do
        it 'does not save the answer' do
          expect { post :create, answer: attributes_for(:invalid_answer), question_id: question.id }.to_not change(Answer, :count)
        end

        it 're-renders question view' do
          post :create, answer: attributes_for(:invalid_question), question_id: question.id
          expect(response).to redirect_to(question)
        end
      end

    end

    describe 'PATCH #update' do
      
      context 'user updates his own answer' do

        context 'valid attributes' do

          it 'asssign the requested question to @question' do
            patch :update, id: user_answer, answer: attributes_for(:answer, user_id: current_user.id)
            expect(assigns(:answer)).to eq user_answer
          end
        
          it 'changes answer attributes' do
            patch :update, id: user_answer, answer: { body: 'new body', user_id: current_user.id }
            user_answer.reload
            expect(user_answer.body).to eq 'new body'
          end

          it 'redirects to updated answer' do
            patch :update, id: user_answer, answer: attributes_for(:answer, user_id: current_user.id)
            expect(response).to redirect_to user_answer.question
          end

        end

        context 'invalid attributes' do
          before { patch :update, id: user_answer, answer: { body: nil, user_id: nil } }

          it 'does not change answer attributes' do
            expect(user_answer.body).to eq 'MyText'
          end

          it 're-render edit view' do
            expect(response).to render_template :edit
          end

        end

      end

      context 'user updates other user answer' do
        
        it 'redirects to root path' do
          patch :update, id: answer, answer: attributes_for(:answer)
          expect(response).to redirect_to root_path
        end

      end

    end

    describe 'PATCH #select' do
        
      context "User selects answer for his question" do
        let(:user_question) { create(:question, user_id: current_user.id) }
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


      context "User tries to select somebody s else question" do
        
        it 'question author can select a question' do
          patch :select, id: answer.id
          answer.reload
          expect(answer.selected).to eq(false)
        end
       
      end
    end

    describe 'DELETE #destroy' do

      context 'User deletes his own question' do

        it 'deletes requested answer' do
          user_answer
          expect { delete :destroy, id: user_answer }.to change(Answer, :count).by(-1)
        end

        it 'redirects to question view' do
          question = user_answer.question
          delete :destroy, id: user_answer
          expect(response).to redirect_to question
        end

      end

      context 'deletes somebody else question' do
       
        it 'can not delete the requested question' do
          answer
          expect { delete :destroy, id: answer }.to change(Answer, :count).by(0)
        end

        it 'redirects to root path' do
          answer
          delete :destroy, id: answer
          expect(response).to redirect_to root_path
        end
    

      end
   
    end

  end

end
