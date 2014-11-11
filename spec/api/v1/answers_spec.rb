require 'rails_helper'

describe 'Answers API' do
  let(:question) { create(:question) }
  let(:access_token) { create(:access_token) }
  let(:answers) { create_list(:answer, 2, question: question) }
  let!(:answer) { answers.first }
  let!(:comments) { create_list(:comment, 2, commentable_type: "Answer", commentable_id: answer.id)  } 
  let!(:comment) { comments.last } #possible bug if comment.first and TODO: why last?
  let!(:attachments) { create_list(:attachment, 2, attachmentable_id: answer.id, attachmentable_type: "Answer")  } 
  let(:attachment) { attachments.last } #TODO: 1 elem


  describe 'GET index' do

    it_behaves_like 'API Authenticable'
    
    
    context 'Authorized' do

      before do
        get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token
      end


      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end


      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          check_json(answer, attr, "answers/0/#{attr}")
        end
      end

      context 'Comments' do
        
        it 'contains comments' do
          expect(response.body).to have_json_size(2).at_path("answers/0/comments")
        end
        
        %w(id body created_at updated_at commentable_type).each do |attr|
          it "comment object contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr).to_json).at_path("answers/0/comments/0/#{attr}")
          end
        end
 
      end

      context 'Attachments' do
        
        it 'contains attachments' do
          expect(response.body).to have_json_size(2).at_path("answers/0/attachments")
        end
        
        %w(id file_url file_name).each do |attr|
          it "comment object contains #{attr}" do
            expect(response.body).to be_json_eql(attachment.send(attr).to_json).at_path("answers/0/attachments/0/#{attr}")
          end
        end
 
      end
    end

    def do_request(options = {})
      get "/api/v1/questions/#{question.id}/answers", {format: :json}.merge(options)
    end

  end


  describe 'GET show' do

    it_behaves_like 'API Authenticable'
    
    context 'Authorized' do


      before do
        get "/api/v1/answers/#{answer.id}", format: :json, access_token: access_token.token
      end


      it 'returns 200 status code' do
        expect(response.status).to eq 200
      end


      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          check_json(answer, attr, "answer/#{attr}")
        end
      end


      context 'Comments' do
        
        it 'contains comments' do
          expect(response.body).to have_json_size(2).at_path("answer/comments")
        end
        
        %w(id body created_at updated_at commentable_type).each do |attr|
          it "comment object contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr).to_json).at_path("answer/comments/0/#{attr}")
          end
        end
 
      end


      context 'Attachments' do
        
        it 'contains attachments' do
          expect(response.body).to have_json_size(2).at_path("answer/attachments")
        end
        
        %w(id file_url file_name).each do |attr|
          it "comment object contains #{attr}" do
            expect(response.body).to be_json_eql(attachment.send(attr).to_json).at_path("answer/attachments/0/#{attr}")
          end
        end
 
      end

    end

    def do_request(options = {})
      get "/api/v1/answers/#{answer.id}", { format: :json }.merge(options)
    end

  end

end