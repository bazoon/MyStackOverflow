class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file
      t.string :attachmentable_type
      t.integer :attachmentable_id

      t.timestamps
    end

    add_index :attachments, :attachmentable_id
    add_index :attachments, :attachmentable_type

  end
end
