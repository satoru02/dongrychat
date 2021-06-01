# == Schema Information
#
# Table name: spaces
#
#  id              :bigint           not null, primary key
#  comments_count  :integer
#  episode         :integer
#  episode_title   :string
#  image_path      :string
#  media           :integer          default("mv"), not null
#  name            :string           not null
#  overview        :text
#  resource_digest :string           not null
#  resource_token  :string           not null
#  season          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  tmdb_comp_id    :integer
#  tmdb_mv_id      :integer
#  tmdb_tv_id      :integer
#
class SpaceSerializer
  include JSONAPI::Serializer
  set_type :space
  attributes :id, :name, :media, :season, :episode, :episode_title, :image_path, :tmdb_comp_id, :tmdb_tv_id, :tmdb_mv_id, :created_at, :overview, :tag_list
  attribute :subscribed do |space, params|
    params[:condition]
  end
  attribute :comments_count do |space|
    space.comments.length
  end

  attribute :users do |space|
    UserSerializer.new(space.users)
  end
end
