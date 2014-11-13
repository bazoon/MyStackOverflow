require 'rails_helper'

RSpec.describe 'Rating' do
  
  let!(:user) { create(:user) }
  let(:other_user) { create(:user) } 
  let(:question) { create(:question, user: user) }
  let(:first_answer) { create(:answer, question: question) }
  let!(:answer) { create(:answer, user: user) }
  let!(:second_answer) { create(:answer, user: user) }

  it 'changes user rating by 1 if he answers a question first' do
    expect { create(:answer, question: question, user: other_user) }.to change(other_user, :rating).by(Answer::FIRST_WEIGHT)
  end

  
  it 'changes user rating by 3 if he answer own question first' do
    expect { create(:answer, question: question, user: user) }.to change(user, :rating).by(Answer::OWN_FIRST_WEIGHT)
  end

  it 'changes user rating by if he answer own question' do
    expect { first_answer; create(:answer, question: question, user: user) }.to change(user, :rating).by(Answer::OWN_WEIGHT)
  end

end