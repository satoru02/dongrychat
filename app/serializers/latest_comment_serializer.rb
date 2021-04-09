# class LatestCommentSerializer
#   include JSONAPI::Serializer
#   set_type :latest_comment
#   attributes :id, :content, :created_at

#   attribute :user do |comment|
#     CommentUserSerializer.new(comment.user)
#   end
# end
