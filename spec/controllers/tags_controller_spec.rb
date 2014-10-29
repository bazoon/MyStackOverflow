require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  let!(:user) { create(:user) }
  let!(:question) { create(:question, body: 'BODY', user_id: user.id) }
  let!(:question2) { create(:question, body: 'BODY', user_id: user.id) }
  let!(:tag) { create(:tag, name: 'TAG') }
  let!(:tag2) { create(:tag, name: 'TAG2') }
  let!(:tagging) { create(:tagging, tag_id: tag.id, taggable_id: question.id, taggable_type: 'Question') }
  let!(:tagging2) { create(:tagging, tag_id: tag.id, taggable_id: question2.id, taggable_type: 'Question') }

  describe '#GET search' do
    
    sign_in_user  

    it 'Fill @question with array of questions tagged with tag' do
      get :search, tag: 'TAG'
      expect(assigns(@questions)[:questions]).to match_array([question, question2])
    end

    it 'Renders Search template' do
      get :search, tag: 'TAG'
      expect(response).to render_template 'search'
    end

  end


  describe '#GET tags' do

    sign_in_user  

    it 'returns searched tags as json' do
      tags = Tag.find_or_new('TA')
      xhr :get, :tags, q: 'TA', format: :json
      expect(response.body).to eq(tags.to_json)
    end
    
  end

end
