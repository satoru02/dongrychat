class AddIndexToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    # add_index :subscriptions, :user_id
    # add_index :subscriptions, :space_id
    add_index :subscriptions, [:user_id, :space_id], unique: true
  end
end
