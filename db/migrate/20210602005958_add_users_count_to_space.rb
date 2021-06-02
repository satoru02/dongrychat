class AddUsersCountToSpace < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :users_count, :integer
  end
end
