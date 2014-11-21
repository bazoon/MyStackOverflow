require 'rails_helper'

RSpec.describe Answer, type: :model do
  
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should belong_to(:user) }
  it { should belong_to(:question) }

  let(:question) { create(:question) }
  let!(:answer_1) { create(:answer, question: question) }
  let!(:answer_2) { create(:answer, question: question) }

  
  it 'can select an answer' do
    answer_1.set_as_selected
    answer_1.reload
    expect(answer_1.selected).to eq(true)
  end

  it 'selects one question and all others become unselected' do
    answer_1.set_as_selected
    answer_2.set_as_selected
    answer_1.reload
    answer_2.reload
    # binding.pry
    expect(answer_1.selected).to eq(false)
    expect(answer_2.selected).to eq(true)
  end

  it 'returns VOTE_WEIGHT' do
    expect(answer_1.vote_weight).to eq(Answer::VOTE_WEIGHT)
  end

  it 'return VOTE_DOWN_WEIGHT' do
    expect(answer_1.vote_down_weight).to eq(Answer::VOTE_DOWN_WEIGHT)
  end

  it 'returns class_underscore' do
    expect(answer_1.class_underscore).to eq(answer_1.class.to_s.underscore)
  end

  it 'deselects all questions' do
    answer_1.update(selected: true)
    Answer.deselect
    answer_1.reload
    expect(answer_1.selected).to eq(false)
  end

  it 'returns email' do
    expect(answer_1.show_title).to eq("Answer: #{answer_1.body}")
  end

  it 'returns self' do
    expect(answer_1.show_object).to eq(answer_1.question)
  end

  # describe 'update_rating' do
  #   let(:user) { create(:user) } 
  #   let(:question) { create(:question, user: user) } 
  #   let(:answer) { create(:answer, user: user) } 
  #   let(:other_question) { create(:question) } 

  #   it 'increases user rating by OWN_FIRST_WEIGHT if user first answers own question' do
      
  #     expect { answer.send(:update_rating) }.to change(user, :rating).by(Answer::OWN_FIRST_WEIGHT)

  #   end

    
  # end


end
