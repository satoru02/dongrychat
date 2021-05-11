class AddColumsToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :action, :integer
    add_column :notifications, :checked, :boolean, default: false, null: false
    add_column :notifications, :user_id, :integer, null: false
  end
end
