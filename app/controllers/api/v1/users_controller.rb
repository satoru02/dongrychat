module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!

      def me
        serializer = UserSerializer.new(current_user)
        render json: serializer.serializable_hash.to_json
      end

      def update
      end
    end
  end
end