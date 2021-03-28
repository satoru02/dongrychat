class SpaceChannel < ApplicationCable::Channel
  def subscribed
    # for comment
    stream_from "space_channel_#{params[:space]}"

    # for appearance check
    redis.set("user_#{current_user.id}_online", "1")
    stream_from "space_channel_for_appearance"
    ActionCable.server.broadcast("space_channel_for_appearance", user_id: current_user.id, online: true)
  end

  def unsubscribed
    redis.del("user_#{current_user.id}_online")
    ActionCable.server.broadcast("space_channel_for_appearance", user_id: current_user.id, online: false)
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

  private

    def redis
     Redis.new
    end
end
