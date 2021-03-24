module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user, only: [:update]

      def me
        serializer = UserSerializer.new(current_user)
        render json: serializer.serializable_hash.to_json
      end

      def update
        if @user.update!(user_params)
          serializer = UserSerializer.new(current_user)
          render json: serializer.serializable_hash.to_json
        else
          render json: { error: @user.errors.full_messages.join(' ')}, status: :unprocessable_entity
        end
      end

      def following
        @user = User.find(params[:id])
        @following_users = @user.following
        serializer = FollowingSerializer.new(@following_users)
        render json: serializer.serializable_hash.to_json
      end

      def followers
        @user = User.find(params[:id])
        @user_followers = @user.followers
        serializer = FollowerSerializer.new(@user_followers)
        render json: serializer.serializable_hash.to_json
      end

      private

        def set_user
          @user = User.find(params[:id])
        end

        def user_params
          params.require(:user).permit(
            :name, :email, :about, :location, :password, :password_confirmation
          )
        end
    end
  end
end