require 'rails_helper'

RSpec.describe Tag, :type => :model do

  let!(:tags) { [create(:tag, name: 'foo'), create(:tag, name: 'football')] }

  describe '.find_or_new' do
  
    it 'return array of tags for searched tag' do
      expect(Tag.find_or_new('fo')).to match_array(tags.map { |tag| { id: tag.name, name: tag.name } })
    end

    it 'returns new tag if search did not succeed' do
      expect(Tag.find_or_new('bar')).to eq([id: 'bar', name: 'New: bar'])
    end

  end

end
