require 'rails_helper'

RSpec.describe Question, type: :model do

  let!(:question) {  create(:question) }
  let!(:question2) { create(:question) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should have_many(:answers) }
  it { should belong_to(:user) }

  # it 'can assign tags' do
  #   question.tag_list = 'one,two,three'
  #   expect(question.tag_list).to eq 'one,two,three'
  # end

  # it 'can find tagged question' do
  #   question.tag_list = 'one,two,three'
  #   expect([Question.tagged_with('one').first,
  #           Question.tagged_with('two').first,
  #           Question.tagged_with('three').first]).to match_array([question, question, question])
  # end

  # it 'can handle duplication' do
  #   question.tag_list = 'one,two,three,one,two,three'
  #   expect(question.tag_list).to eq 'one,two,three'
  # end

  it 'can search with tags string' do
    question.tag_tokens = 'one, two'
    question2.tag_tokens = 'three, four'
    expect(Question.tagged_with("one, four")).to match_array([question, question2])
  end

   it 'can search with tags array' do
    question.tag_tokens = 'one, two'
    question2.tag_tokens = 'three, four'
    expect(Question.tagged_with(["one", "four"])).to match_array([question, question2])
  end

  it 'can be voted for' do
    expect { question.up_by(1) }.to change(question, :rating).by(1)
  end

  it 'can be voted against' do
    expect { question.down_by(1) }.to change(question, :rating).by(-1)
  end


end
 