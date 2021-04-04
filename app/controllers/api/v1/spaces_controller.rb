module Api
  module V1
    class SpacesController < ApplicationController
      before_action :authorize_access_request!

      def index
        # fix -> scope
        @spaces = current_user.spaces.includes(:comments).sort_by{|space| [-space.unread_comments(current_user).length]}
        serializer = MultiSpaceSerializer.new(@spaces, {params: {current_user: current_user}})
        render json: serializer.serializable_hash.to_json
      end

      # from space component. unstable.
      def enter
        if params[:media] === 'mv'
          @space = Space.create_or_search_mv(params.permit(:name, :media, :image_path, :tmdb_mv_id, :page, :per_page), current_user)
          @media = 'tv'
          @condition = current_user.subscribed?(@space.id)
          @comments = @space.comments.includes(:user).pager(page: params[:page], per: params[:per_page])

          if @space.comments.exists?
            serializer = CommentSerializer.new(@comments, {params: {condition: @condition, media: @media}})
          else
            serializer = TvSpaceSerializer.new(@space, {params: {condition: @condition, media: @media}})
          end
        elsif params[:media] === 'tv'
          @space = Space.create_or_search_tv(params.permit(:name, :season, :episode, :episode_title, :media, :tmdb_tv_id, :image_path, :page, :per_page), current_user)
          @media = 'mv'
          @condition = current_user.subscribed?(@space.id)
          @comments = @space.comments.includes(:user).pager(page: params[:page], per: params[:per_page])

          if @space.comments.exists?
            serializer = CommentSerializer.new(@comments, {params: {condition: @condition, media: @media}})
          else
            serializer = MvSpaceSerializer.new(@space, {params: {condition: @condition, media: @media}})
          end
        end
        render json: serializer.serializable_hash.to_json
      end

      # from top subscription. stable.
      def enter_from_subscription
        @space = Space.find_by(id: params[:space_id])
        @space.comments.update_all(confirmation: true)
        @condition = current_user.subscribed?(@space.id)
        if @space.tv?
          @media = 'tv'
        elsif @space.mv?
          @media = 'mv'
        end
        @comments = @space.comments.includes(:user).pager(page: params[:page], per: params[:per_page])
        serializer = CommentSerializer.new(@comments, {params: {condition: @condition, media: @media}})
        render json: serializer.serializable_hash.to_json
      end

      def trend
        @spaces = Space.getTrend(params.permit(:record_count, :media))
        serializer = MultiSpaceSerializer.new(@spaces, {params: {current_user: current_user}})
        render json: serializer.serializable_hash.to_json
      end
    end
  end
end