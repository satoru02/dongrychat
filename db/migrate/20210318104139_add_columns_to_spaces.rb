class AddColumnsToSpaces < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :episode_title, :integer
    add_column :spaces, :tmdb_tv_id, :integer
    add_column :spaces, :tmdb_mv_id, :integer
    add_column :spaces, :image_path, :string
  end
end
