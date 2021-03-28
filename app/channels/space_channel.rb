class SpaceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "space_channel_#{params[:space]}"
  end

  def unsubscribed
  end

  def speak(data)
    # for space
    ActionCable.server.broadcast("space_channel_#{data["space_id"]}", {
      comment: data["comment"],
      user: data["user_id"],
      space: data["space_id"]
    })
    comment = Comment.new(user_id: data["user_id"], space_id: data["space_id"], content: data["comment"])
    comment.save!
    # for toppage subscription
    ActionCable.server.broadcast("topsub_channel", {
      comment: data["comment"],
      user_id: data["user_id"],
      space_id: data["space_id"]
    })
  end
end
