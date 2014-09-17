class AddSelectedToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :selected, :boolean
  end
end
