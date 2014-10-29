require 'rails_helper'

RSpec.describe ConfirmationsController, type: :controller do

  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  let!(:confirmed_user) { create(:user, email: 'example@example.com', name: 'foo') } 

  describe '#GET show' do
    

    it 'assign a user ' do
      get :show, confirmation_token: confirmed_user.confirmation_token
      expect(assigns(:user)).to eq(confirmed_user)
    end

    it 'redirects to questions_path if user was found' do

      set_after_sign_in_path

      get :show, confirmation_token: confirmed_user.confirmation_token
      expect(response).to redirect_to(questions_path)
    end

    it 'redirects to root_path if user not found' do
      get :show, confirmation_token: 'dummy_token'
      expect(response).to redirect_to(root_path)
    end


   
    

  end




end


