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
          @space = Space.create_or_search_mv(params.permit(:name, :media, :image_path, :tmdb_mv_id), current_user)
          serializer = MvSpaceSerializer.new(@space, {params: {current_user: current_user}})
        elsif params[:media] === 'tv'
          @space = Space.create_or_search_tv(params.permit(:name, :season, :episode, :episode_title, :media, :tmdb_tv_id, :image_path), current_user)
          serializer = TvSpaceSerializer.new(@space, {params: {current_user: current_user}})
        end
        render json: serializer.serializable_hash.to_json
      end

      # from top subscription. stable.
      def enter_from_subscription
        @space = Space.find_by(id: params[:space_id])
        @space.comments.update_all(confirmation: true)
        if @space.tv?
          serializer = TvSpaceSerializer.new(@space, {params: {current_user: current_user}})
        elsif @space.mv?
          serializer = MvSpaceSerializer.new(@space, {params: {current_user: current_user}})
        end
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