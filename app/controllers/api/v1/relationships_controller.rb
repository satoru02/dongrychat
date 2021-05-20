module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :authorize_access_request!

      def create
        @user = User.find(params[:followed_id])
        if current_user.follow(@user)
          current_user.create_active_notification(@user)
          response_success('Relationship', 'created')
        else
          response_bad_request
        end
      end

      def destroy
        @user = Relationship.find_by(follower_id: params[:id], followed_id: params[:followed_id]).followed
        if current_user.unfollow(@user)
          response_success('Relationship', 'destroyed')
        else
          response_bad_request
        end
      end
    end
  end
end