class SpaceChannel < ApplicationCable::Channel
  def subscribed
    # for comment
    stream_from "space_channel_#{params[:space]}"
  end

  def unsubscribed
  end

  def speak(data)
    # for space
    ActionCable.server.broadcast("space_channel_#{data["space_id"]}", {
      attributes: {
        content: data["content"],
        space_id: data["space_id"],
        user: {
          data: {
            attributes: {
              id: data["user_id"],
              name: data["user_name"],
              appearance: true,
              avatar_url: if current_user.avatar.attached?; then current_user.cdn_ready_blob_path(current_user.avatar) end
            }
          }
        }
      }
    })

    comment = Comment.new(user_id: data["user_id"], space_id: data["space_id"], content: data["content"])
    comment.save!

    # for toppage subscription
    ActionCable.server.broadcast("topsub_channel", {
      comment: data["content"],
      user_id: data["user_id"],
      space_id: data["space_id"]
    })
  end
end
