class CreateReputations < ActiveRecord::Migration
  def change
    create_table :reputations do |t|
      t.integer :reputationable_id
      t.string :reputationable_type
      t.integer :reputation

      t.timestamps
    end
  end
end
