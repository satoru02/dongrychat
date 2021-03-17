class ChangeColumnOfSpace < ActiveRecord::Migration[6.0]
  def change
    change_column :spaces, :resource_token, :string
    change_column :spaces, :resource_digest, :string
  end
end
