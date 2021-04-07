class DeleteConfirmationColumnFromComment < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :confirmation, :boolean
  end
end
