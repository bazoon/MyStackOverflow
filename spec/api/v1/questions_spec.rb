require 'rails_helper'

describe 'Question API' do
  let!(:questions) { create_list(:question, 2) }
  let(:question) { questions.first }
  let(:access_token) { create(:access_token) }
  let!(:answer) { create(:answer, question: question) }


  describe 'GET index' do
    

    context 'Access token is empty' do
    
      it 'returns 401 status code' do
        get "/api/v1/questions", format: :json
        expect(response.status).to eq 401
      end
    end

    context 'Access token is invalid' do
      it 'returns 401 status code' do
        get "/api/v1/questions", format: :json, access_token: 'khbewuihdwqh21e'
        expect(response.status).to eq 401
      end
    end
    


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




      context 'answers' do
        
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("questions/0/answers")
        end

        %w(id body created_at updated_at).each do |attr|
          it "answer object contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("questions/0/answers/0/#{attr}")
          end
        end

      end



    end

  end


  describe '#show' do

    context 'Access token is empty' do
      it 'returns 401 status code' do
        get "/api/v1/questions/#{question.id}", format: :json
        expect(response.status).to eq 401
      end
    end

    context 'Access token is invalid' do
      it 'returns 401 status code' do
        get "/api/v1/questions/#{question.id}", format: :json, access_token: 'khbewuihdwqh21e'
        expect(response.status).to eq 401
      end
    end
    


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
      
      context 'answers' do
        
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("question/answers")
        end

        %w(id body created_at updated_at).each do |attr|
          it "answer object contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("question/answers/0/#{attr}")
          end
        end

      end
    
    end


      
  end










end