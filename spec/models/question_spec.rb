require 'rails_helper'

RSpec.describe Question, type: :model do

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should have_many(:answers) }
  it { should belong_to(:user) }
end
 