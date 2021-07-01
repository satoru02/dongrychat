class AddRelationshipsCountToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :active_relationships_count, :integer
    add_column :users, :passive_relationships_count, :integer
  end
end
