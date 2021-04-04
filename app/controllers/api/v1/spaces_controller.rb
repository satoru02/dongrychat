module Api
  module V1
    class SpacesController < ApplicationController
      before_action :authorize_access_request!

      def index
        # fix -> scope
        @spaces = current_user.spaces.includes(:comments, :users).sort_by{|space| [-space.unread_comments(current_user).length]}
        serializer = MultiSpaceSerializer.new(@spaces, {params: {current_user: current_user}})
        render json: serializer.serializable_hash.to_json
      end

      # from space component. unstable.
      def enter
        if params[:media] === 'mv'
          @space = Space.create_or_search_mv(params.permit(:name, :media, :image_path, :tmdb_mv_id, :page, :per_page), current_user)
          @media = 'tv'
        elsif params[:media] === 'tv'
          @space = Space.create_or_search_tv(params.permit(:name, :season, :episode, :episode_title, :media, :tmdb_tv_id, :image_path, :page, :per_page), current_user)
          @media = 'mv'
        end

        @condition = current_user.subscribed?(@space.id)

        if @space.comments.exists?
          @comments = @space.comments.includes(:user).order("created_at ASC").pager(page: params[:page], per: params[:per_page])
          serializer = CommentSerializer.new(@comments, {params: {condition: @condition, media: @media}})
        else
          serializer = MultiSpaceSerializer.new(@space, {params: {condition: @condition, media: @media}})
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

        if @space.comments.exists?
          @comments = @space.comments.includes(:user).order("created_at ASC").pager(page: params[:page], per: params[:per_page])
          serializer = CommentSerializer.new(@comments, {params: {condition: @condition, media: @media}})
        else
          serializer = MultiSpaceSerializer.new(@space, {params: {condition: @condition, media: @media}})
        end
        render json: serializer.serializable_hash.to_json
      end

      def trend
        @spaces = Space.includes(:users).getTrend(params.permit(:record_count, :media))
        serializer = MultiSpaceSerializer.new(@spaces, {params: {current_user: current_user}})
        render json: serializer.serializable_hash.to_json
      end
    end
  end
end