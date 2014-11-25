class AddAvtarUrl < ActiveRecord::Migration
  def change
    add_column :users, :avatar_url, :string
  end
end
