shared_examples_for 'API Unauthorized' do |path|

  context 'Access token is empty' do
    it 'returns 401 status code' do
      get path, format: :json
      expect(response.status).to eq 401
    end
  end

  context 'Access token is invalid' do
    it 'returns 401 status code' do
      get path, format: :json, access_token: 'khbewuihdwqh21e'
      expect(response.status).to eq 401
    end
  end
    
end
