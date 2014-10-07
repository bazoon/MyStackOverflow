require 'rails_helper'

RSpec.describe RatingModifier do
  
  let!(:user) { create(:user) }
  let!(:voter) { create(:user) } 

  let!(:question) { create(:question, user_id: user.id) }
  let!(:answer) { create(:answer, user_id: user.id) }
  let!(:voter_answer) { create(:answer, user_id: voter.id) }
  let!(:voter_question) { create(:question, user_id: voter.id) }
  let(:rating_modifier) { RatingModifier.new(voter) }


  it 'increase user reputation by 5 if his Q is voted up' do
    rating_modifier.vote_up(question)
    user.reload
    expect(user.rating).to eq(5)
  end

  it 'increase user reputation by 10 if his A is voted up' do
    rating_modifier.vote_up(answer)
    user.reload
    expect(user.rating).to eq(10)
  end

  it 'increase user reputation by 15 if his A is accepted' do
    rating_modifier.accept(answer)
    user.reload
    expect(user.rating).to eq(15)
  end

  it 'decreases user reputation by 2 if his Q is voted down' do
    rating_modifier.vote_down(question)
    user.reload
    expect(user.rating).to eq(-2)
  end

  it 'decreases user reputation by 2 if his A is voted down' do
    rating_modifier.vote_down(answer)
    user.reload
    expect(user.rating).to eq(-2)
  end

  it 'decreases user reputation by -1 if he votes down some A' do
    rating_modifier.vote_down(answer)
    voter.reload
    expect(voter.rating).to eq(-1)
  end

  it 'can not change own reputation by voting for own answer' do
    rating_modifier.vote_up(voter_answer)
    user.reload
    expect(user.rating).to eq(0)
  end

  it 'can not change own reputation by voting for own question' do
    rating_modifier.vote_up(voter_question)
    user.reload
    expect(user.rating).to eq(0)
  end


end
