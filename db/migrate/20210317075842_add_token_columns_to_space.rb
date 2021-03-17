class AddTokenColumnsToSpace < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :resource_token, :string, null: false
    add_column :spaces, :resource_digest, :string, null: false
  end
end
