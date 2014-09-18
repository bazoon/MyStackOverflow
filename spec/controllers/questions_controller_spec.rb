require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:question) {  create(:question) }
  

  
  shared_examples 'index show' do
    
    describe 'GET #index' do
      let(:questions) { create_list(:question, 2) }
      before { get :index }

      it 'populates an array with all questions' do
        expect(assigns(:questions)).to match_array(questions)
      end

      it 'renders index view' do
        expect(response).to render_template(:index)
      end

    end

    describe 'GET #show' do
      before { get :show, id: question }

      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it 'renders show view' do
        expect(response).to render_template(:show)
      end
    end
  end


  context 'Unauthorized user' do
    
    include_examples 'index show'

    describe 'GET #new' do
      it 'can not ask a new question' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      it 'can not ask a new question' do
        get :edit, id: question
        expect(response).to redirect_to(new_user_session_path)
      end
      
    end



    describe 'POST #create' do

      it 'redirects to sign_in path' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to(new_user_session_path)
      end
      
      it 'it does not save question in the database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(0)
      end

    end


    describe 'PATCH #update' do

      it 'redirects to sign_in path' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'does not change question attributes' do
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
        question.reload
        expect(question.title).to eq 'title'
        expect(question.body).to eq 'body'
      end
    
    end

    describe 'DELETE #destroy' do

      it 'redirects to sign_in path' do
        delete :destroy, id: question
        expect(response).to redirect_to(new_user_session_path)
      end


      it 'does not delete requested question' do
        question
        expect { delete :destroy, id: question }.to change(Question, :count).by(0)
      end

    end


  end

  context 'Authorized user' do

    let(:current_user) { create(:user) }
    let(:user_question) { create(:user_question, user_id: current_user.id) }
    
    sign_in_user

    include_examples 'index show'

    describe 'GET #new' do

      before do
        
        get :new
      end

      it 'assigns a new question to @question' do
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'renders new view' do
        expect(response).to render_template(:new)
      end

    end

    describe 'GET #edit' do

      context 'User tries to edit his own question' do
        
        before { get :edit, id: user_question }

        it 'assigns the requested question to @question' do
          expect(assigns(:question)).to eq user_question
        end

        it 'renders edit view' do
          expect(response).to render_template :edit
        end

      end
    end

    describe 'POST #create' do

      context 'with valid attributes' do
        it 'saves the new question in the database' do
          expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, question: attributes_for(:question)
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
        end

        it 're-renders new view' do
          post :create, question: attributes_for(:invalid_question)
          expect(response).to render_template :new
        end
      end
    end


    describe 'PATCH #update' do
    
      context 'user updates his own question' do

        context 'valid attributes' do
        
          it 'asssign the requested question to @question' do
            patch :update, id: user_question, question: attributes_for(:user_question, user_id: current_user) #del
            expect(assigns(:question)).to eq user_question
          end
          
          it 'changes question attributes' do
            patch :update, id: user_question, question: { title: 'new title', body: 'new body' }
            user_question.reload
            expect(user_question.title).to eq 'new title'
            expect(user_question.body).to eq 'new body'
          end

          it 'redirects to updated question' do
            patch :update, id: user_question, question: attributes_for(:question, user_id: current_user)
            expect(response).to redirect_to user_question
          end
        end  

        context 'invalid attributes' do
          before { patch :update, id: user_question, question: {title: 'new title', body: nil, user_id: current_user } }

          it 'does not change question attributes' do
            user_question.reload
            expect(user_question.title).to eq 'user title'
            expect(user_question.body).to eq 'body'
          end

          it 're-renders edit view' do
            expect(response).to render_template :edit
          end

        end
      end

      context 'user updates other user question' do
        it 'redirects to root path' do
          patch :update, id: question, question: attributes_for(:question, user_id: current_user)
          expect(response).to redirect_to root_path
        end
      end
    end

    describe 'DELETE #destroy' do

      it 'deletes requested question' do
        user_question
        expect { delete :destroy, id: user_question }.to change(Question, :count).by(-1)
      end

      it 'can not delete other user question' do #!
        question
        expect { delete :destroy, id: question }.to change(Question, :count).by(0)
      end

      
      it 'tries to delete other user question' do
        question
        delete :destroy, id: question
        expect(response).to redirect_to root_path
      end

      it 'redirects to index view' do
        user_question
        delete :destroy, id: user_question
        expect(response).to redirect_to questions_path
      end

    end
    
    
  end
  


  

  

end
























