class ChangeColumnsNameOfNotification < ActiveRecord::Migration[6.0]
  def change
    rename_column :notifications, :action, :genre
  end
end
