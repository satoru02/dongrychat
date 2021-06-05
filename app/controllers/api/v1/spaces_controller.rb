module Api
  module V1
    class SpacesController < ApplicationController
      before_action :authorize_access_request!, only: [:unsubscribed, :subscribed, :comments]
      before_action :set_space, only: [:subscribed, :comments, :reviews]
      before_action :set_condition, only: [:subscribed, :comments]

      def unsubscribed
        if params[:media] === 'mv'
          @space = Space.create_or_search_mv(mv_space_params, current_user)
        elsif params[:media] === 'tv'
          @space = Space.create_or_search_tv(tv_space_params, current_user)
        end

        @condition = current_user.subscribed?(@space.id)
        serializer = set_space_serializer(@space, @condition, params[:media])
        render_json(serializer)
      end

      def subscribed
        serializer = set_space_serializer(@space, @condition, params[:media])
        render_json(serializer)
      end

      def trend
        @spaces = Space.includes(:users, :tags, :comments).get_trend(params).paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = set_trend_space_serializer(@spaces)
        render_json(serializer)
      end

      #fix
      def popular
        @spaces = Space.includes(:users, :subscriptions).get_popular(params)[3..7]
        serializer = set_popular_space_serializer(@spaces)
        render_json(serializer)
      end

      def comments
        if (@condition === true) && (@space.comments_unconfirmed_by(current_user) > 0)
          @space.comments_confirmed_by(current_user)
        end

        @comments = @space.comments.order_by_latest.paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = set_comment_serializer(@comments, @condition, params[:media])
        render_json(serializer)
      end

      def reviews
        @reviews = @space.reviews
        serializer = ReviewSerializer.new(@reviews)
        render_json(seriaizer)
      end

      private

        def enter_params(condition, media)
          { params: { condition: condition, media: media } }
        end

        def set_trend_space_serializer(spaces)
          TrendSpaceSerializer.new(spaces)
        end

        def set_popular_space_serializer(spaces)
          PopularSpaceSerializer.new(spaces)
        end

        def set_space_serializer(space, condition, media)
          SpaceSerializer.new(space, enter_params(condition, media))
        end

        def set_comment_serializer(comments, condition, media)
          CommentSerializer.new(comments, enter_params(condition, media))
        end

        def set_space
          @space = Space.find_by(id: params[:id])
        end

        def set_condition
          @condition = current_user.subscribed?(@space.id)
        end

        def mv_space_params
          params.permit(:name, :media, :image_path, :tmdb_mv_id, :overview, :page, :per_page, :tag_list => [])
        end

        def tv_space_params
          params.permit(:name, :season, :episode, :episode_title, :media, :tmdb_comp_id, :tmdb_tv_id, :image_path, :overview, :page, :per_page, :tag_list => [])
        end
    end
  end
end