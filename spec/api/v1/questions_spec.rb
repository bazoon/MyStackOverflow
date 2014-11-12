require 'rails_helper'

describe 'Question API' do
  let!(:questions) { create_list(:question, 2) }
  let(:question) { questions.first }
  let(:access_token) { create(:access_token) }
  let!(:answer) { create(:answer, question: question) }


  describe 'GET index' do
    
    it_behaves_like 'API Authenticable'    

    context 'authorized' do
    
    
      before do
        get '/api/v1/questions', format: :json, access_token: access_token.token
      end

      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2).at_path('questions')
      end

      it "contains timestamp" do
        expect(response.body).to be_json_eql(questions.first.created_at.to_json).at_path("questions/0/created_at")
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end

    end

    def do_request(options = {})
      get '/api/v1/questions', { format: :json }.merge(options)
    end
  

  end


  describe 'GET #show' do

    it_behaves_like 'API Authenticable'

    context 'Authorized' do

      before do
        get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token
      end


      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end


      %w(id title body created_at updated_at attachments comments).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("question/#{attr}")
        end
      end
      
      
    
    end

    def do_request(options = {})
       get "/api/v1/questions/#{question.id}", { format: :json }.merge(options)
    end  

      
  end


  describe 'POST #create' do

    let(:create_path) { '/api/v1/questions/' }
    
    # before do
    #   post create_path, format: :json,question: attributes_for(:question), access_token: access_token.token
    # end

    it_behaves_like 'API Authenticable'

    def do_request(options = {})
      post create_path, { question: attributes_for(:question), format: :json }.merge(options)
    end      
    

    context 'Authorized' do

      it 'saves the new other_question in the database' do
        expect { post create_path, format: :json, question: attributes_for(:question), format: :json, access_token: access_token.token }.to change(Question, :count).by(1)
      end

      it 'does not save the question if attributes are not valid' do
        expect { post create_path, question: attributes_for(:invalid_question), format: :json, access_token: access_token.token }.to_not change(Question, :count)
      end

    end

  end










end