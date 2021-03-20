class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :user_name, :string, null: false
    add_column :users, :about, :text
    add_column :users, :location, :string
    add_column :users, :gender, :integer
    add_column :users, :birthday, :string
    add_column :users, :sns_links, :text, array: true, default: []
  end
end
