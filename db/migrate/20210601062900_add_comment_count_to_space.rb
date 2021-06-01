class AddCommentCountToSpace < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :comments_count, :integer
  end
end
