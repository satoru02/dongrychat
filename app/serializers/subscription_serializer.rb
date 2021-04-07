class SubscriptionSerializer
  include JSONAPI::Serializer
  set_type :subscription
  attributes :id, :user_id, :space_id
end
