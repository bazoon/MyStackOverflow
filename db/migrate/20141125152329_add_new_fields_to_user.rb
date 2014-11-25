class AddNewFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :website, :string
    add_column :users, :real_name, :string
    add_column :users, :birth_date, :date
  end
end
