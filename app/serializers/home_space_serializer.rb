class HomeSpaceSerializer
  include JSONAPI::Serializer
  set_type :space
  attributes :id, :name, :media, :season, :episode, :episode_title, :image_path, :tmdb_tv_id, :tmdb_mv_id, :users, :created_at, :overview, :tag_list
  attribute :unconfirmed_comments do |space, params|
    space.comments_unconfirmed_by(params[:current_user])
  end

  attribute :latest_comment do |space|
    space.comments.last
  end
end