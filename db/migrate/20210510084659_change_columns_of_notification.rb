class ChangeColumnsOfNotification < ActiveRecord::Migration[6.0]
  def change
    rename_column :notifications, :user_id, :sender_id
    add_column :notifications, :receiver_id, :integer, null: false
    add_index :notifications, :receiver_id
  end
end
