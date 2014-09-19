require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:question) {  create(:question) }
  let(:answer) { create(:answer, question_id: question.id) }
  
  context 'Authorized user' do
    
    describe '#POST create' do
      
      context 'with valids attributes' do

        it 'saves the new comment in the database' do
          request.env["HTTP_REFERER"] = question_path(question)
          expect { post :create, answer_id: answer.id, comment: attributes_for(:comment) }.to change(Comment, :count).by(1)
        end

        # it 'redirects to question show view' do
        #   post :create, answer: attributes_for(:answer), question_id: question.id
        #   expect(response).to redirect_to question_path(assigns(:question))
        # end

      end
      



    end







  end






end