class SetDefaultReputationToZero < ActiveRecord::Migration
  def change
      change_column :reputations, :reputation, :integer, default: 0
  end
end
