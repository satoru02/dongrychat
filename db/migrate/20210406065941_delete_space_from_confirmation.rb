class DeleteSpaceFromConfirmation < ActiveRecord::Migration[6.0]
  def change
    remove_column :confirmations, :space_id, :integer
  end
end
