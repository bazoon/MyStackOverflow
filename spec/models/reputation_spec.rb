require 'rails_helper'

RSpec.describe Reputation, :type => :model do

  it { should validate_presence_of :reputationable_type }
  it { should validate_presence_of :reputationable_id }

end
