class MultiSpaceSerializer
  include JSONAPI::Serializer

  set_type :space
  attributes :id, :name, :media, :season, :episode, :episode_title, :image_path, :tmdb_tv_id, :tmdb_mv_id
  attribute :unread_comments do |obj|
    obj.unread_comments.length
  end
end