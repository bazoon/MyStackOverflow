require 'rails_helper'

RSpec.describe RatingModifier do
  
  
  let!(:user) { create(:user) }
  let!(:voter) { create(:user) } 

  let!(:question) { create(:question, user: user) } #TODO: без id

  let(:answer) { create(:answer, user: user) }

  let!(:voter_answer) { create(:answer, user: voter) }
  let!(:voter_question) { create(:question, user: voter) }
  let(:rating_modifier) { RatingModifier.new(voter) }

  #TODO: design patterns


  it 'creates Vote objects if someone votes' do
    expect { rating_modifier.vote_up(question) }.to change(question.votes, :count).by(1)
  end


  it 'increase user reputation by VOTE_WEIGHT if his Q is voted up' do
    rating_modifier.vote_up(question)
    user.reload
    expect(user.rating).to eq(Question::VOTE_WEIGHT)
  end

  it 'increase user reputation by VOTE_WEIGHT if his A is voted up' do
    answer.reload
    expect { rating_modifier.vote_up(answer); user.reload }.to change(user, :rating).by(Answer::VOTE_WEIGHT)
  end

  it 'increase user reputation by ACCEPT_WEIGHT if his A is accepted' do
    answer.reload    
    expect { rating_modifier.accept(answer); user.reload }.to change(user, :rating).by(Answer::ACCEPT_WEIGHT)
  end

  it 'decreases user reputation by VOTE_DOWN_WEIGHT if his Q is voted down' do
    expect { rating_modifier.vote_down(question); user.reload }.to change(user, :rating).by(-Question::VOTE_DOWN_WEIGHT)
  end

  it 'decreases user reputation by VOTE_DOWN_WEIGHT if his A is voted down' do
    answer.reload
    expect { rating_modifier.vote_down(answer); user.reload }.to change(user, :rating).by(-Answer::VOTE_DOWN_WEIGHT)
  end

  it 'decreases user reputation by VOTE_DOWN_PRICE if he votes down some A' do
    expect { rating_modifier.vote_down(answer); voter.rating }.to change(voter, :rating).by(-User::VOTE_DOWN_PRICE)
  end

  it 'can not change own reputation by voting for own answer' do
    expect { rating_modifier.vote_up(voter_answer); user.reload }.to_not change(user, :rating)
  end

  it 'can not change own reputation by voting for own question' do
    expect { rating_modifier.vote_up(voter_question) }.to_not change(user, :rating)
  end


end
