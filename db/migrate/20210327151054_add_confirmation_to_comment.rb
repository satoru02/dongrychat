class AddConfirmationToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :confirmation, :boolean, default: :false
  end
end
