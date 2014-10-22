require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  describe 'GET up' do
    let!(:user) { create(:user) }
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer) }

    sign_in_user

    it 'assigns @voteable to question if voteable is a question' do
      get :vote_up, question_id: question, format: :json
      expect(assigns(:voteable)).to eq(question)
    end

    it 'assigns @voteable to answer if voteable is an answer' do
      get :vote_up, answer_id: answer, format: :json
      expect(assigns(:voteable)).to eq(answer)
    end

    # it 'calls vote_up for RatingModifier' do
    #   get :up, question_id: question, format: :json
    #   allow(assigns(:rm)).to receive(:vote_up) { 1 }

    #   expect(assigns(:rm)).to have_received(:vote_up)
    # end
    
#TODO: проверить был вызван метод с такими то параметрами, контролле не отвествененн за это внизу

    # it 'question raiting +1' do
    #   get :up, question_id: question, format: :json 
    #   question.reload
    #   expect(question.rating).to eq(1)
    # end


  end

end
