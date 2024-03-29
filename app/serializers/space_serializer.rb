# == Schema Information
#
# Table name: spaces
#
#  id               :bigint           not null, primary key
#  air_date         :string
#  comments_count   :integer
#  creators         :text             default([]), is an Array
#  episode          :integer
#  episode_title    :string
#  homepage         :string
#  image_path       :string
#  media            :integer          default("mv"), not null
#  name             :string           not null
#  overview         :text
#  resource_digest  :string           not null
#  resource_token   :string           not null
#  season           :integer
#  users_count      :integer
#  watchlists_count :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tmdb_comp_id     :integer
#  tmdb_mv_id       :integer
#  tmdb_tv_id       :integer
#
# Indexes
#
#  index_spaces_on_episode  (episode)
#  index_spaces_on_name     (name)
#  index_spaces_on_season   (season)
#
class SpaceSerializer
  include JSONAPI::Serializer
  set_type :space
  attributes :id, :name, :media, :season, :episode, :episode_title, :image_path, :tmdb_comp_id, :tmdb_tv_id, :tmdb_mv_id, :created_at, :overview, :tag_list, :creators, :air_date, :homepage

  attribute :subscribed do |space, params|
    params[:condition]
  end

  attribute :watchlist do |space, params|
    params[:watchlist]
  end

  attribute :watchlist_count do |space|
    space.watchlists.size
  end

  attribute :comments_count do |space|
    space.comments.size
  end

  attribute :reviews_count do |space|
    space.reviews.size
  end

  attribute :users_count do |space|
    space.users.size
  end
end
