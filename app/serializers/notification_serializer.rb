class NotificationSerializer
  include JSONAPI::Serializer
  set_type :notification
  attributes :id, :genre, :checked, :receiver_id, :sender_id, :sender
  attribute :sender do |notification|
    UserSerializer.new(notification.sender)
  end
end