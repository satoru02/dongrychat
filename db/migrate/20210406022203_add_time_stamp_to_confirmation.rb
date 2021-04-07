class AddTimeStampToConfirmation < ActiveRecord::Migration[6.0]
  def change
    change_column :confirmations, :created_at, :datetime, default: -> {'CURRENT_TIMESTAMP'}
    change_column :confirmations, :updated_at, :datetime, default: -> {'CURRENT_TIMESTAMP'}
  end
end
