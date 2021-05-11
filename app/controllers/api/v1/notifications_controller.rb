module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authorize_access_request!

      def index
        notifications = current_user.passive_notification.unchecked
        serializer = NotificationSerializer.new(notifications)
        render_json(serializer)
      end
    end
  end
end