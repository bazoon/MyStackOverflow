class AddAvatarWebToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_web, :string
  end
end
