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

    it 'assigns @voteable to answer if voteable is an answer' do
      get :vote_down, answer_id: answer, format: :json
      expect(assigns(:voteable)).to eq(answer)
    end

    it 'calls vote_up for RatingModifier' do
      rm = RatingModifier.new(user)
      allow(RatingModifier).to receive(:new) { rm }
      expect(rm).to receive(:vote_up).with(question)
      get :vote_up, question_id: question, format: :json
    end

    it 'calls vote_down for RatingModifier' do
      rm = RatingModifier.new(user)
      allow(RatingModifier).to receive(:new) { rm }
      expect(rm).to receive(:vote_down).with(question)
      get :vote_down, question_id: question, format: :json
    end
    
    it 'Publish question after vote_up call' do
      expect(PrivatePub).to receive(:publish_to)
      get :vote_up, question_id: question, format: :json
    end

    it 'Publish question after vote_down call' do
      expect(PrivatePub).to receive(:publish_to)
      get :vote_down, question_id: question, format: :json
    end

  end

end
