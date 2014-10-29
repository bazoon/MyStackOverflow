require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do

  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  describe '#save_email' do
    
    let(:old_user) { create(:user, email: 'email@email.com', name: 'foo') }


    it 'redirects to root_path if user already has account' do
      set_mock_hash_for_facebook
      post :save_email, user: { :email => 'email@email.com', :name => 'user_1' }
      expect(response).to redirect_to(root_path)
    end


    it 'renders ask_for_email' do
      set_mock_hash_for_facebook
      post :save_email, user: { :name => 'user_1' }
      expect(response).to render_template('ask_for_email')
    end



  end





end
