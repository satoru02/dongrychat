class UsersReviewsSerializer
  include JSONAPI::Serializer
  set_type :users_review
  attributes :id, :content, :created_at, :space
end