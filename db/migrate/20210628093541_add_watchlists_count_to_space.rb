class AddWatchlistsCountToSpace < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :watchlists_count, :integer
  end
end
