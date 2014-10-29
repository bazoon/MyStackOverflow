require 'rails_helper'

describe ApplicationPolicy do

  subject { ApplicationPolicy }

  let(:user) { create :user }
  let(:admin) { create :user, admin: true }

  permissions :index? do
    
    it 'grants access if user is a guest' do
      expect(subject).to permit(nil, create(:comment))
    end

    it 'grants access if user is owner of comment' do
      expect(subject).to permit(user, create(:comment, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:comment))
    end

  end

  permissions :show? do
    
    it 'grants access if user is a guest' do
      expect(subject).to permit(nil, create(:comment))
    end

    it 'grants access if user is owner of comment' do
      expect(subject).to permit(user, create(:comment, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:comment))
    end

  end


  permissions :update? do
    
    it 'denies access if user is a guest' do
      expect(subject).not_to permit(nil, create(:comment))
    end

    it 'grants access if user is owner of comment' do
      expect(subject).to permit(user, create(:comment, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:comment))
    end

  end

  permissions :edit? do
    
    it 'denies access if user is a guest' do
      expect(subject).not_to permit(nil, create(:comment))
    end

    it 'grants access if user is owner of comment' do
      expect(subject).to permit(user, create(:comment, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:comment))
    end

  end


  permissions :destroy? do
    
    it 'denies access if user is a guest' do
      expect(subject).not_to permit(nil, create(:comment))
    end

    it 'grants access if user is owner of comment' do
      expect(subject).to permit(user, create(:comment, user: user))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, create(:comment))
    end

  end




end
