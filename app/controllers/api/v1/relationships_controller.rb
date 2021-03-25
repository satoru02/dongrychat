module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :authorize_access_request!

      def create
        user = User.find(params[:followed_id])
        current_user.follow(user)
      end

      def destroy
        user = Relationship.find_by(follower_id: params[:id], followed_id: params[:followed_id]).followed
        current_user.unfollow(user)
      end
    end
  end
end