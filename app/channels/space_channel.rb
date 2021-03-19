class SpaceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "space_channel_#{params[:space]}"
  end

  def unsubscribed
  end

  def speak(data)
    # for space
    ActionCable.server.broadcast("space_channel_#{data["space"]}", {
      comment: data["comment"],
      user: data["user_id"],
      space: data["space"]
    })

    # for toppage subscription
    ActionCable.server.broadcast("topsub_channel", {
      comment: data["comment"],
      space_id: data["space"]
    })
  end
end
