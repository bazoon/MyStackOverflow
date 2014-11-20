class CreateQuestionSubscriptions < ActiveRecord::Migration
  def change
    create_table :question_subscriptions do |t|
      t.integer :question_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_index :question_subscriptions, [:user_id, :question_id], unique: true
  end
end
