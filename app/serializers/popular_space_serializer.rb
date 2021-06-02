class PopularSpaceSerializer
  include JSONAPI::Serializer
  set_type :space
  attributes :id, :name, :media, :season, :episode, :episode_title, :image_path, :tmdb_tv_id, :tmdb_mv_id, :created_at, :overview

  attribute :users do |space|
    UserSerializer.new(space.users)
  end
end