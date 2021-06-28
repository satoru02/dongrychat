class AddHomepageToSpace < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :homepage, :string
  end
end
