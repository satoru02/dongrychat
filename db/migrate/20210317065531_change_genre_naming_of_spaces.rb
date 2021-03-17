class ChangeGenreNamingOfSpaces < ActiveRecord::Migration[6.0]
  def change
    rename_column :spaces, :genre, :media
  end
end
