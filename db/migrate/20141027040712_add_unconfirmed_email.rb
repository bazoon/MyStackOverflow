class AddUnconfirmedEmail < ActiveRecord::Migration
  def change
    add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
  end
end
