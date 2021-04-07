# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  space_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_comments_on_space_id  (space_id)
#  index_comments_on_user_id   (user_id)
#
class CommentSerializer
  include JSONAPI::Serializer
  set_type :comment
  attributes :id, :content, :user_id, :space_id, :user, :created_at
  attribute :space do |comment, params|
    SpaceSerializer.new(comment.space, {params: { condition: params[:condition]}})
  end

  attribute :user do |comment|
    CommentUserSerializer.new(comment.user)
  end
end
