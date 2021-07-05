# == Schema Information
#
# Table name: watchlists
#
#  id         :bigint           not null, primary key
#  comment    :string
#  status     :boolean          default(FALSE), not null
#  time       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  space_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_watchlists_on_space_id              (space_id)
#  index_watchlists_on_user_id               (user_id)
#  index_watchlists_on_user_id_and_space_id  (user_id,space_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (space_id => spaces.id)
#  fk_rails_...  (user_id => users.id)
#
class Watchlist < ApplicationRecord
  belongs_to :user, :counter_cache => :watchlists_count
  belongs_to :user, :counter_cache => :watchlog_count
  belongs_to :space, :counter_cache => true
  validates :user_id, presence: true
  validates :space_id, presence: true

  scope :specified_by, -> (current_status){
    where(status: current_status)
  }

  class << self
    def reserved user, space_id
      user.watchlists.find_by(space_id: space_id)
    end
  end
end
