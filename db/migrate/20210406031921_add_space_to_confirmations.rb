class AddSpaceToConfirmations < ActiveRecord::Migration[6.0]
  def change
    add_column :confirmations, :space_id, :integer, null: false
  end
end
