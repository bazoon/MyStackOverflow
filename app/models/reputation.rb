class Reputation < ActiveRecord::Base
  
  validates :reputationable_type, :reputationable_id, presence: true

end
