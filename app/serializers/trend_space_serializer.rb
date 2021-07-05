class TrendSpaceSerializer
  include JSONAPI::Serializer

  set_type :space
  attributes :id, :name, :media, :season, :episode, :episode_title, :image_path, :tmdb_tv_id, :tmdb_mv_id, :created_at, :overview

  attribute :latest_comment do |space|
    space.comments.last
  end

  attribute :users_count do |space|
    space.users.size
  end

  attribute :comments_count do |space|
    space.comments.size
  end

  attribute :latest_comment_user do |space|
    if space.comments.present?
      CommentUserSerializer.new(space.comments.last.user)
    end
  end
end