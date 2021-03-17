class AddDefaultValueToSpace < ActiveRecord::Migration[6.0]
  def change
    change_column :spaces, :genre, :integer, :default => 0
  end
end
