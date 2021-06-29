class AddAirdateToSpace < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :air_date, :string
  end
end
