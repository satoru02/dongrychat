class SpaceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "space_channel_#{params[:space]}"
  end

  def unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast("space_channel_#{data["space"]}", {
      comment: data["comment"],
      user: data["user_id"],
      space: data["space"]
    })
  end
end
