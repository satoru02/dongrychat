class AddWatchlistsCountToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :watchlists_count, :integer
    add_column :users, :watchlog_count, :integer
  end
end
