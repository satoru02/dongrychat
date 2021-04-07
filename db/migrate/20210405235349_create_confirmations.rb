class CreateConfirmations < ActiveRecord::Migration[6.0]
  def change
    create_table :confirmations do |t|
      t.integer :user_id
      t.integer :comment_id

      t.timestamps
    end
    add_index :confirmations, :user_id
    add_index :confirmations, :comment_id
    add_index :confirmations, [:user_id, :comment_id], unique: true
  end
end
