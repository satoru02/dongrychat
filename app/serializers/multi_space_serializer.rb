class MultiSpaceSerializer
  include JSONAPI::Serializer

  set_type :space
  attributes :id, :name, :media, :season, :episode, :episode_title, :image_path, :tmdb_tv_id, :tmdb_mv_id
  has_many :comments, serializer: CommentsSerializer
end