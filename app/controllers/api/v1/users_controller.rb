module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user, only: [:show, :update, :following, :followers, :subscriptions, :new_comments]

      def me
        serializer = UserSerializer.new(current_user)
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

      def online
        users = current_user.online_followings
        serializer = FollowingSerializer.new(users)
        render_json(serializer)
      end

      def subscriptions
        @spaces = @user.spaces.order_by_comments(@user).paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = set_home_space_serializer(@spaces, @user)
        render_json(serializer)
      end

      def new_comments
        render json: { new_comments: @user.unconfirmed_comments }
      end

      private

        def set_user
          @user = User.friendly.find(params[:id].downcase)
        end

        def current_user_params(user)
          { params: { current_user: user } }
        end

        def set_home_space_serializer(spaces, user)
          HomeSpaceSerializer.new(spaces, current_user_params(user))
        end

        def user_params
          params.require(:user).permit(
            :name, :email, :about, :location, :password, :password_confirmation, :sns_links => []
          )
        end
    end
  end
end