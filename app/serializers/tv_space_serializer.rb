class TvSpaceSerializer
  include JSONAPI::Serializer
  set_type :tv_space
  attributes :id, :name, :media, :season, :episode, :episode_title, :image_path, :tmdb_tv_id, :users

  attribute :comments do |obj|
    CommentSerializer.new(obj.comments.includes(:user))
  end

  attribute :subscribed do |obj, params|
    params[:current_user].subscribed? obj.id
  end
end