module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user, only: [:show, :update, :following, :followers]

      def me
        serializer = UserSerializer.new(current_user)
        render_json(serializer)
      end

      def index
        user = User.online
        serializer = UserSerializer.new(user)
        render_json(serializer)
      end

      def show
        serializer = UserSerializer.new(@user)
        render_json(serializer)
      end

      def update
        if @user.update!(user_params)

          if params[:file_name]
            @user.attach_avatar(params[:file_name])
          end

          serializer = UserSerializer.new(current_user)
          render_json(serializer)
        else
          render json: { error: @user.errors.full_messages.join(' ')}, status: :unprocessable_entity
        end
      end

      def following
        @following_users = @user.following
        serializer = FollowingSerializer.new(@following_users)
        render_json(serializer)
      end

      def followers
        @user_followers = @user.followers
        serializer = FollowerSerializer.new(@user_followers)
        render_json(serializer)
      end

      def online_following
        # users = current_user.following
        # serializer = UserSerializer.new(users)
        # render_json(serializer)
      end

      private

        def set_user
          @user = User.find(params[:id])
        end

        def user_params
          params.require(:user).permit(
            :name, :email, :about, :location, :password, :password_confirmation,  :sns_links => []
          )
        end
    end
  end
end