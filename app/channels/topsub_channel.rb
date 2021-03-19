class TopsubChannel < ApplicationCable::Channel
  def subscribed
    stream_from "topsub_channel"
  end

  def unsubscribed
  end
end
