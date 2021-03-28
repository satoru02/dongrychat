class MvSpaceSerializer
  include JSONAPI::Serializer

  set_type :mv_space
  attributes :id, :name, :media, :image_path, :tmdb_mv_id, :users, :comments
end