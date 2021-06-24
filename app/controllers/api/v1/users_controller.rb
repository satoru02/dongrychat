module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user, only: [:show, :update, :following, :followers,
                                      :subscriptions, :new_comments, :reviews,
                                      :watchlists, :watchlog]

      def me
        serializer = set_user_serializer(current_user)
        render_json(serializer)
      end

      def show
        serializer = set_user_serializer(@user)
        render_json(serializer)
      end

      def update
        if @user.update!(user_params)

          if params[:file_name]
            @user.attach_avatar(params[:file_name])
          end

          serializer = set_user_serializer(current_user)
          render_json(serializer)
        else
          render json: { error: @user.errors.full_messages.join(' ')}, status: :unprocessable_entity
        end
      end

      def following
        @following = @user.following.paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = set_following_serializer(@following)
        render_json(serializer)
      end

      def followers
        @followers = @user.followers.paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = set_followers_serializer(@followers)
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

      def reviews
        @reviews = @user.reviews.paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = set_users_reviews_serializer(@reviews)
        render_json(serializer)
      end

      def watchlists
        @unwatched_spaces = @user.unwatched_spaces.paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = set_registered_space_serializer(@unwatched_spaces)
        render_json(serializer)
      end

      def watchlog
        @watched_spaces = @user.watched_spaces.paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = set_registered_space_serializer(@watched_spaces)
        render_json(serializer)
      end

      # def online
      #   users = current_user.online_followings
      #   serializer = FollowingSerializer.new(users)
      #   render_json(serializer)
      # end

      private

        def set_user
          @user = User.find(params[:id])
        end

        def current_user_params(user)
          { params: { current_user: user } }
        end

        def set_following_serializer(users)
          FollowingSerializer.new(users)
        end

        def set_followers_serializer(users)
          FollowerSerializer.new(users)
        end

        def set_user_serializer(user)
          UserSerializer.new(user)
        end

        def set_home_space_serializer(spaces, user)
          HomeSpaceSerializer.new(spaces, current_user_params(user))
        end

        def set_users_reviews_serializer(reviews)
          UsersReviewsSerializer.new(reviews)
        end

        def set_registered_space_serializer(spaces)
          RegisteredSpaceSerializer.new(spaces)
        end

        def user_params
          params.require(:user).permit(
            :name, :email, :about, :location, :password, :password_confirmation, :sns_links => []
          )
        end
    end
  end
end