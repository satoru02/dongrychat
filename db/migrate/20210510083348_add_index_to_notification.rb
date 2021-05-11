class AddIndexToNotification < ActiveRecord::Migration[6.0]
  def change
    add_index :notifications, :user_id
  end
end
