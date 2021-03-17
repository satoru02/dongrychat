class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :space
      t.text :content, null: false
      t.timestamps
    end
  end
end
