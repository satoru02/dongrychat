class NotificationSerializer
  include :JSONAPI::Serializer
  set_type :notification
  attributes :id, :genre, :checked, :receiver_id, :sender_id, :user
end