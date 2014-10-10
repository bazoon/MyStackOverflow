require 'rails_helper'

RSpec.describe QuestionVoteController, type: :controller do

  describe 'GET up' do
    let!(:user) { create(:user) }
    let!(:question) { create(:question) }

    sign_in_user

    it 'assigns @question' do
      get :up, question_id: question, format: :json
      expect(assigns(:question)).to eq(question)
    end

    it 'question raiting +1' do
      get :up, question_id: question, format: :json 
      question.reload
      expect(question.rating).to eq(1)
    end


  end

end
