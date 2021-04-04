class MvSpaceSerializer
  include JSONAPI::Serializer
  set_type :space
  attributes :id, :name, :media, :image_path, :tmdb_mv_id, :users

  # attribute :comments do |obj|
  #   CommentSerializer.new(obj.comments.includes(:user))
  # end

  attribute :subscribed do |space, params|
    params[:condition]
  end
end