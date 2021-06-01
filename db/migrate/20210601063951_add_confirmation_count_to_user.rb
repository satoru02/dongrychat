class AddConfirmationCountToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :confirmations_count, :integer
  end
end
