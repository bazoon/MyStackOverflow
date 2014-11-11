shared_examples_for 'API Authenticable' do

  context 'Access token is empty' do
    it 'returns 401 status code' do
      
      do_request
      expect(response.status).to eq 401
    end
  end

  context 'Access token is invalid' do
    it 'returns 401 status code' do
      do_request access_token: 'khbewuihdwqh21e'
      expect(response.status).to eq 401
    end
  end
    
end
