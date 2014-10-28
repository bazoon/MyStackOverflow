require 'rails_helper'

describe AnswerPolicy do

  subject { AnswerPolicy }

  let(:user) { create :user }
  let(:admin) { create :user, admin: true }

  permissions :index? do
    
    it 'grants access if user is a guest' do
      expect(subject).to permit(nil, create(:answer))
    end

    it 'grants access if user is owner of comment' do
      expect(subject).to permit(user, create(:answer, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:answer))
    end

  end

  permissions :show? do
    
    it 'grants access if user is a guest' do
      expect(subject).to permit(nil, create(:answer))
    end

    it 'grants access if user is owner of comment' do
      expect(subject).to permit(user, create(:answer, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:answer))
    end

  end


  permissions :update? do
    
    it 'denies access if user is a guest' do
      expect(subject).not_to permit(nil, create(:answer))
    end

    it 'grants access if user is owner of comment' do
      expect(subject).to permit(user, create(:answer, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:answer))
    end

  end

  permissions :edit? do
    
    it 'denies access if user is a guest' do
      expect(subject).not_to permit(nil, create(:answer))
    end

    it 'grants access if user is owner of comment' do
      expect(subject).to permit(user, create(:answer, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:answer))
    end

  end


  permissions :destroy? do
    
    it 'denies access if user is a guest' do
      expect(subject).not_to permit(nil, create(:answer))
    end

    it 'grants access if user is owner of comment' do
      expect(subject).to permit(user, create(:answer, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:answer))
    end

  end




end
