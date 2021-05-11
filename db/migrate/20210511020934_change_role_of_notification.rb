class ChangeRoleOfNotification < ActiveRecord::Migration[6.0]
  def change
    change_column :notifications, :action, :integer, default: 0
  end
end
