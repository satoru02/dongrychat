class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.string :type
      t.belongs_to :user
      t.belongs_to :space
      t.string :content, null: false

      t.timestamps
    end
  end
end
