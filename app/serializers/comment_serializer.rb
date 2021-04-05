class CommentSerializer
  include JSONAPI::Serializer
  set_type :comment
  attributes :id, :content, :user_id, :space_id, :confirmation, :user, :created_at
  attribute :space do |comment, params|
    SpaceSerializer.new(comment.space, {params: { condition: params[:condition]}})
  end
end