require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:attributes) { attributes_for(:question) } 
  let(:other_question) {  create(:question, attributes) }
  
  
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
      let!(:answers) { create_list(:answer, 2, question_id: other_question.id) }
      before { get :show, id: other_question }

      it 'assigns the requested other_question to @other_question' do
        expect(assigns(:question)).to eq other_question
      end

      it 'renders show view' do
        expect(response).to render_template(:show)
      end


      it 'assign a requested to @question' do
        expect(assigns(:question)).to eq other_question
      end

      it 'assigns question answers to @answers' do
        expect(assigns(:answers)).to match_array other_question.answers
      end

    end
  end

  context 'Unauthenticated user' do
    
    include_examples 'index show'

    describe 'GET #new' do
      it 'can not ask a new other_question' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      it 'can not ask a new other_question' do
        get :edit, id: other_question
        expect(response).to redirect_to(new_user_session_path)
      end
      
    end

    describe 'POST #create' do

      it 'redirects to sign_in path' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to(new_user_session_path)
      end
      
      it 'it does not save other_question in the database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(0)
      end

    end

    describe 'PATCH #update' do

      it 'redirects to sign_in path' do
        patch :update, id: other_question, question: attributes_for(:question), format: :js
        expect(response.status).to eq(401)
      end

      it 'does not change other_question attributes' do
        patch :update, id: other_question, question: { title: 'new title', body: 'new body' }, format: :js
        other_question.reload
        expect(other_question.title).to eq attributes[:title]
        expect(other_question.body).to eq attributes[:body]
      end
    
    end

    describe 'DELETE #destroy' do

      it 'redirects to sign_in path' do
        delete :destroy, id: other_question
        expect(response).to redirect_to(new_user_session_path)
      end


      it 'does not delete requested other_question' do
        other_question
        expect { delete :destroy, id: other_question }.to change(Question, :count).by(0)
      end

    end

  end

  context 'Authenticated user' do
    sign_in_user
    let(:question) { create(:question, user_id: @user.id) }

    
    include_examples 'index show'

    describe 'GET #new' do

      before { get :new }
      
      it 'assigns a new other_question to @other_question' do
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'renders new view' do
        expect(response).to render_template(:new)
      end

    end

    describe 'GET #edit' do

      context 'User tries to edit his own question' do
        
        before { get :edit, id: question }

        it 'assigns the requested other_question to @question' do
          expect(assigns(:question)).to eq question
        end

        it 'renders edit view' do
          expect(response).to render_template :edit
        end

      end
    end

    describe 'POST #create' do

      context 'with valid attributes' do
        it 'saves the new other_question in the database' do
          expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, question: attributes_for(:question)
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the other_question' do
          expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
        end

        it 're-renders new view' do
          post :create, question: attributes_for(:invalid_question)
          expect(response).to render_template :new
        end
      end
    end


    describe 'PATCH #update' do
    
      context 'user updates his own other_question' do

        context 'valid attributes' do
        
          it 'asssign the requested other_question to @question' do
            patch :update, id: question, question: attributes_for(:question, user_id: @user)
            expect(assigns(:question)).to eq question
          end
          
          it 'changes question attributes' do
            patch :update, id: question, question: { title: 'new title', body: 'new body' }
            question.reload
            expect(question.title).to eq 'new title'
            expect(question.body).to eq 'new body'
          end

          it 'redirects to updated question' do
            patch :update, id: question, question: attributes_for(:question, user_id: @user)
            expect(response).to redirect_to question
          end
        end  

        context 'invalid attributes' do
          before { patch :update, id: question, question: {title: 'new title', body: nil, user_id: @user }}

          it 'does not change question attributes' do
            question.reload
            expect(question.title).to eq attributes[:title]
            expect(question.body).to eq attributes[:body]
          end
        end
      end


    end

    describe 'DELETE #destroy' do

      it 'deletes requested question' do
        question
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end

      it 'redirects to index view' do
        question
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end

    end

    context 'Forbiden actions' do

      describe 'GET #edit' do
      
        it 'tries to edit other user question', format: :js do
          get :edit,  id: other_question 
          expect(response).to redirect_to(root_path)
        end

      end  
    
      describe 'DELETE #destroy' do
      
        it 'tries to delete other user question' do
          delete :destroy,  id: other_question
          expect(response).to redirect_to(root_path)
        end

      end  

      describe 'PATCH #update' do
        
        it 'can not update other user question attributes' do
          patch :update, id: other_question, question: attributes_for(:question, body: "New body"), format: :js
          other_question.reload
          expect(other_question.body).to eq attributes[:body]
        end

        it 'redirects or renders forbidden' do
          patch :update, id: other_question, question: attributes_for(:question, body: "New body")
          expect(response).to redirect_to(root_path)
        end

        # it 'tries to updated other user question' do
        #   patch { :update, id: other_question, question: attributes_for(:question, user_id: @user), format: :js }.to raise_error(CanCan::AccessDenied)
        #   expect(response.status).to eq(403)
        # end     
      end   


    end

  end
  
end
























