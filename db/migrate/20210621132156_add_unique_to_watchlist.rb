class AddUniqueToWatchlist < ActiveRecord::Migration[6.0]
  def change
    add_index :watchlists, [:user_id, :space_id], unique: true
  end
end
