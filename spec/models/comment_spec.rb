require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it { should validate_presence_of :body }

  let(:comment) { create(:comment) } 


  describe 'search representation' do

    it 'shows itself as' do
      expect(comment.show_title).to eq("Comment: #{comment.body}")
    end

    it 'links to its commentable' do
      expect(comment.show_object).to eq(comment.commentable.show_object)
    end

  end
  

end
