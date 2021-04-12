class AddOverviewToSpace < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :overview, :text
  end
end
