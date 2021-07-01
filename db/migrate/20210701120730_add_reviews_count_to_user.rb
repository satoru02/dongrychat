class AddReviewsCountToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :reviews_count, :integer
  end
end
