class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.string :name, null: false
      t.integer :genre, null: false
      t.integer :season
      t.integer :episode

      t.timestamps
    end
  end
end
