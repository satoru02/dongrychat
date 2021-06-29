class AddCreatorsToSpace < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :creators, :text, array: true, default: []
  end
end
