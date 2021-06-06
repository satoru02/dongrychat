class ReviewSerializer
  include JSONAPI::Serializer
  set_type :review
  attributes :id, :content, :created_at, :user
  attribute :user do |review|
    UserSerializer.new(review.user)
  end
end