class ChangeColumnTypeOfSpace < ActiveRecord::Migration[6.0]
  def change
    change_column :spaces, :episode_title, :string
  end
end
