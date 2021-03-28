class TvSpaceSerializer
  include JSONAPI::Serializer

  set_type :tv_space
  attributes :id, :name, :media, :season, :episode, :episode_title, :image_path, :tmdb_tv_id, :users, :comments
end