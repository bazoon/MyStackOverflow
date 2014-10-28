require 'rails_helper'

describe QuestionPolicy do
  subject { QuestionPolicy }

  let(:user) { create :user }
  let(:admin) { create :user, admin: true }

  # let(:question) { create(:question) }

  permissions :index? do
    
    it 'grants access if user is a guest' do
      expect(subject).to permit(nil, create(:question))
    end

    it 'grants access if user is owner of question' do
      expect(subject).to permit(user, create(:question, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:question))
    end

  end

  permissions :show? do
    
    it 'grants access if user is a guest' do
      expect(subject).to permit(nil, create(:question))
    end

    it 'grants access if user is owner of question' do
      expect(subject).to permit(user, create(:question, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:question))
    end

  end


  permissions :update? do
    
    it 'denies access if user is a guest' do
      expect(subject).not_to permit(nil, create(:question))
    end

    it 'grants access if user is owner of question' do
      expect(subject).to permit(user, create(:question, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:question))
    end

  end

  permissions :edit? do
    
    it 'denies access if user is a guest' do
      expect(subject).not_to permit(nil, create(:question))
    end

    it 'grants access if user is owner of question' do
      expect(subject).to permit(user, create(:question, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:question))
    end

  end


  permissions :destroy? do
    
    it 'denies access if user is a guest' do
      expect(subject).not_to permit(nil, create(:question))
    end

    it 'grants access if user is owner of question' do
      expect(subject).to permit(user, create(:question, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:question))
    end

  end






end
