require 'rails_helper'

RSpec.describe Answer, type: :model do
  
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }

  let(:question) { create(:question) }
  let!(:answer_1) { create(:answer, question: question) }
  let!(:answer_2) { create(:answer, question: question) }

  it 'has selected answer' do
    answer_1.set_as_selected
    expect(answer_1.selected_answers).to match_array([answer_1])
  end

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




end
