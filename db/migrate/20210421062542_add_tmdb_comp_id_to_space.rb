class AddTmdbCompIdToSpace < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :tmdb_comp_id, :integer
  end
end
