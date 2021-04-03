class TvSpaceSerializer
  include JSONAPI::Serializer

  set_type :tv_space
  attributes :id, :name, :media, :season, :episode, :episode_title, :image_path, :tmdb_tv_id, :users, :comments
  attribute :subscribed do |obj, params|
    params[:current_user].subscribed? obj.id
  end
end