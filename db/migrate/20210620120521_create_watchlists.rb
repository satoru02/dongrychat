class CreateWatchlists < ActiveRecord::Migration[6.0]
  def change
    create_table :watchlists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :space, null: false, foreign_key: true
      t.boolean :status, null: false, default: :false
      t.datetime :time
      t.string :comment

      t.timestamps
    end
  end
end
