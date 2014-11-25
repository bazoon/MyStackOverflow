require 'rails_helper'

RSpec.describe ApplicationHelper do
  
  let(:d) { Time.now } 

  describe '#ld' do
  
    it 'converts non empty date' do
      expect(ld(d)).to eq(I18n.l(d, format: :long))
    end

    it 'returns nil for empty date' do
      expect(ld(nil)).to be_nil
    end

  end

  describe 'icons' do
    
    it 'returns span with specific class' do
      expect(show_icon).to eq content_tag(:span,"",class: "glyphicon glyphicon-folder-open")
      expect(edit_icon).to eq content_tag(:span,"",class: "glyphicon glyphicon-edit")
      expect(del_icon).to eq content_tag(:span,"",class: "glyphicon glyphicon-trash", alt: "delete")
      expect(users_icon).to eq content_tag(:span,"",class: "glyphicon glyphicon-user")
      expect(select_icon).to eq content_tag(:span,"",class: "glyphicon glyphicon-star")
      expect(vote_up_icon).to eq content_tag(:i,"",class: "fa fa-sort-asc fa-3x")
      expect(vote_down_icon).to eq content_tag(:i,"",class: "fa fa-sort-desc fa-3x")
    end
  end

  describe 'labels' do
    
    it 'returns span with specific class' do
      expect(red_label('foo')).to eq(content_tag(:span, 'foo', class: "label label-danger")) 
      expect(green_label('foo')).to eq(content_tag(:span, 'foo', class: "label label-success"))   
    end
    
  end


  describe 'now' do
    it 'returns now time' do
      allow(Time.zone).to receive(:now) { d }
      expect(now).to eq(d)
    end
  end




end
