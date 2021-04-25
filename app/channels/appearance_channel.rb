class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from("appearance_channel")
    redis.set("user_#{current_user.id}_online", "#{current_user.id}")
    ActionCable.server.broadcast("appearance_channel", user_id: current_user.id, online: true)
  end

  def unsubscribed
    redis.del("user_#{current_user.id}_online")
    ActionCable.server.broadcast("appearance_channel", user_id: current_user.id, online: false)
  end

  private

   def redis
    Redis.new
   end
end