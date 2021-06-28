class AddIndexColumnsToSpaces < ActiveRecord::Migration[6.0]
  def change
    add_index :spaces, :name
    add_index :spaces, :season
    add_index :spaces, :episode
  end
end
