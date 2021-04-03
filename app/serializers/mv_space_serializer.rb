class MvSpaceSerializer
  include JSONAPI::Serializer
  set_type :mv_space
  attributes :id, :name, :media, :image_path, :tmdb_mv_id, :users

  attribute :comments do |obj|
    CommentSerializer.new(obj.comments.includes(:user))
  end

  attribute :subscribed do |obj, params|
    params[:current_user].subscribed? obj.id
  end
end