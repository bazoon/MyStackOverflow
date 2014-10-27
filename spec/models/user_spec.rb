require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :name }
  it { should validate_presence_of :password }
  
  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should have_many(:comments) }



  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

    context 'user already has authorization' do
      it 'returns the user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do
      context 'user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }
        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorization for user' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'user does not exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new@user.com' }) }

        it 'creates new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end
        
        it 'returns new user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end

        it 'fills user email' do
          user = User.find_for_oauth(auth)
          expect(user.email).to eq auth.info[:email]
        end

        it 'creates authorization for user' do
          user = User.find_for_oauth(auth)
          expect(user.authorizations).to_not be_empty
        end

        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        context 'user provider does not deliver email' do

          let(:auth) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '123456', info: { email: nil, nickname: "tw01" }) }

          it 'return user without email' do
            user = User.find_for_oauth(auth)
            expect(user.email).to be_empty
          end



        end


      end

    



    end
  end


  describe '#send_confirmation_instructions' do
    let(:user) { create(:user) }
    let(:provider) { 'twitter' }

    it 'check for confirmation_token to be set' do
      user.send_confirmation_instructions(provider)
      expect(user.confirmation_token).to_not be_nil
    end

    it 'Call devise_mailer to deliver confirmation_instructions' do
      mailer = double('mailer')
      allow(mailer).to receive(:deliver)
      allow(user.send(:devise_mailer)).to receive(:confirmation_instructions) { mailer }

      expect(user.send(:devise_mailer)).to receive(:confirmation_instructions)
      user.send_confirmation_instructions(provider)
    end


  end


end
