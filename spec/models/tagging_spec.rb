require 'rails_helper'

RSpec.describe Tagging, :type => :model do
  it { should validate_presence_of :tag_id }
  it { should validate_presence_of :taggable_id }
  it { should validate_presence_of :taggable_type }
end
