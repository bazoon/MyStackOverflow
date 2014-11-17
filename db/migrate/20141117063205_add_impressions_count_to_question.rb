class AddImpressionsCountToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :impressions_count, :integer
  end
end
