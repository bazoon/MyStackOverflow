require 'rails_helper'

RSpec.describe Question, type: :model do

  let(:question) {  create(:question) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should have_many(:answers) }
  it { should belong_to(:user) }


  it 'can have tags' do
    question.tag_list = 'one,two,three'
    expect(question.tag_list).to eq 'one,two,three'
    expect(Question.tagged_with('one').first).to eq question
    expect(Question.tagged_with('two').first).to eq question
    expect(Question.tagged_with('three').first).to eq question
  end

  it 'can be voted for' do
    expect { question.vote_up }.to change(question, :rating).by(1)
  end

  it 'can be voted against' do
    expect { question.vote_down }.to change(question, :rating).by(-1)
  end


end
 