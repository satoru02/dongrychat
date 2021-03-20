class ChangeNameColumnsOfUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :user_name
    change_column :users, :name, :string, null: false
  end
end
