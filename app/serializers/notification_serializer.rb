# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  checked     :boolean          default(FALSE), not null
#  genre       :integer          default("relationship")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  receiver_id :integer          not null
#  sender_id   :integer          not null
#
# Indexes
#
#  index_notifications_on_receiver_id  (receiver_id)
#  index_notifications_on_sender_id    (sender_id)
#
class NotificationSerializer
  include JSONAPI::Serializer
  set_type :notification
  attributes :id, :genre, :checked, :receiver_id, :sender_id, :sender
  attribute :sender do |notification|
    UserSerializer.new(notification.sender)
  end
end
