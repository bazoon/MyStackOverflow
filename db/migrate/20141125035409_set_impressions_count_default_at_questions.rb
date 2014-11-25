class SetImpressionsCountDefaultAtQuestions < ActiveRecord::Migration
  def change
    change_column :questions, :impressions_count, :integer, default: 0
  end
end
