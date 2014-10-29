require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do

  before { @request.env["devise.mapping"] = Devise.mappings[:user] }
  let(:user) { create(:user) } 

  describe '#save_email' do
    
    let(:old_user) { create(:user, email: 'email@email.com', name: 'foo') }


    it 'redirects to root_path if user already has account' do
      post :save_email, user: { :email => 'email@email.com', :name => 'user_1' }
      expect(response).to redirect_to(root_path)
    end


    it 'renders ask_for_email if no user found' do
      post :save_email, user: { :name => 'user_1' }
      expect(response).to render_template('ask_for_email')
    end

  end

  describe 'Facebook login' do
    
    it 'sign in user if it is found' do
      allow(User).to receive(:find_for_oauth)  { user }
      allow(controller).to receive(:load_omniauth_info) { valid_oauth }
      get :facebook
      expect(controller.current_user).to eq(user)
    end


    it 'asks for email if user is not valid' do
      allow(User).to receive(:find_for_oauth)  { User.new }
      allow(controller).to receive(:load_omniauth_info) { valid_oauth }
      get :facebook
      expect(response).to render_template('ask_for_email')
    end
 


  end



end
