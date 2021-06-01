class PopulateSpaceCommentsCount < ActiveRecord::Migration[6.0]
  def up
    Space.find_each do |space|
      Space.reset_counters(space.id, :comments)
    end
  end
end
