require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) {  create(:question) }
  let(:answer) { create(:answer, question_id: question.id) }
  let(:current_user) { create(:user) }
  let(:user_answer) { create(:answer, user_id: current_user.id) }

  before do
    allow(controller).to receive(:current_user).and_return current_user
  end

  shared_examples "collections" do |collection_class|
    it "is empty when first created" do
      expect(collection_class.new).to be_empty
    end
  end


  
  describe 'GET #index' do
    let(:answers) { create_list(:answer, 2, question_id: question.id) }
    before { get :index, question_id: question.id }
    
    it 'assigns a answer question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'populates array with answers for given question' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'renders index view' do
      expect(response).to render_template(:index)
    end

  end

  describe 'GET #show' do
    before { get :show, id: answer.id }

    it 'assigns a requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show view' do
      expect(response).to render_template(:show)
    end

  end

  describe 'GET #new' do
    
    before { get :new, question_id: question.id }

    it 'assigns a answer question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns a new answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template(:new)
    end

  end

  describe 'GET #edit' do
    before { get :edit, id: answer.id }

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end

  end


  describe 'POST #create' do
    
    context 'with valids attributes' do

      it 'saves the new answer in the database' do
        expect { post :create, answer: attributes_for(:answer), question_id: question.id }.to change(Answer, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, answer: attributes_for(:answer), question_id: question.id
        expect(response).to redirect_to question_path(assigns(:question))
      end

    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question.id }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, answer: attributes_for(:invalid_question), question_id: question.id
        expect(response).to render_template :new
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

      
    context 'user updates other user answer' do
      
      it 'redirects to root path' do
        patch :update, id: answer, answer: attributes_for(:answer)
        expect(response).to redirect_to root_path
      end
    end



    end

  end

  describe "DELETE #destroy" do
    
    it 'deletes requested answer' do
      user_answer
      expect { delete :destroy, id: user_answer }.to change(Answer, :count).by(-1)
    end

    it 'can not delete other user question' do
      answer
      delete :destroy, id: answer
      expect(response).to redirect_to root_path
    end

    it 'redirects to question view' do
      question = user_answer.question
      delete :destroy, id: user_answer
      expect(response).to redirect_to question
    end
 


  end

end
