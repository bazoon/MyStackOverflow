require 'rails_helper'
require 'carrierwave/test/matchers'


RSpec.describe AvatarUploader do
  include CarrierWave::Test::Matchers
  let!(:user) { create(:user) }

  before do
    AvatarUploader.enable_processing = true
    @uploader = AvatarUploader.new(user, :avatar)
    @uploader.store!(File.open("#{Rails.root}/spec/files/test.jpg"))
  end

  after do
    AvatarUploader.enable_processing = false
    @uploader.remove!
  end

  context 'thumb version' do
    it 'should scale down image to be exactly 150 by 150 pixels' do
      expect(@uploader.thumb).to have_dimensions(150, 150)
    end
  end

  it 'stores files' do
    expect(@uploader.store_dir).to eq("uploads/#{user.class.to_s.underscore}/#{@uploader.mounted_as}/#{user.id}")
  end


end
