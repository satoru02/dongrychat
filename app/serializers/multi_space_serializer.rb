class MultiSpaceSerializer
  include JSONAPI::Serializer

  set_type :space
  attributes :id, :name, :media, :season, :episode, :episode_title, :image_path, :tmdb_tv_id, :tmdb_mv_id, :users

  attribute :unread_comments do |obj, params|
    obj.unread_comments(params[:current_user]).length
  end

  attribute :subscribed do |space, params|
    params[:condition]
  end
end