require 'rails_helper'

RSpec.describe SearchController, :type => :controller do

  

    describe 'GET index' do
      %w[ThinkingSphinx Question Answer Comment User].each do |model|
        it "run search on #{model}" do
          expect(model.constantize).to receive(:search).with('query')
          get :index, search: 'query', type: "#{model}"
        end
      end
    end



end
