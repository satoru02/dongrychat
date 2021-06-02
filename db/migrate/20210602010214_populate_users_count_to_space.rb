class PopulateUsersCountToSpace < ActiveRecord::Migration[6.0]
  def change
    def up
      Space.find_each do |space|
        Space.reset_counters(space.id, :users)
      end
    end
  end
end
