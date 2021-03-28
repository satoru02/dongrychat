module Api
  module V1
    class SpacesController < ApplicationController
      before_action :authorize_access_request!

      def index
        @user = User.find_by(id: params[:user_id])
        @spaces = @user.spaces.includes(:comments).sort_by{|space| [-space.unread_comments.length]}
        serializer = MultiSpaceSerializer.new(@spaces)
        render json: serializer.serializable_hash.to_json
      end

      # from space component. unstable.
      def enter
        if params[:media] === 'mv'
          @space = Space.create_or_search_mv(params.permit(:name, :media, :image_path, :tmdb_mv_id), current_user)
          serializer = MvSpaceSerializer.new(@space)
        elsif params[:media] === 'tv'
          @space = Space.create_or_search_tv(params.permit(:name, :season, :episode, :episode_title, :media, :tmdb_tv_id, :image_path), current_user)
          serializer = TvSpaceSerializer.new(@space)
        end
        render json: serializer.serializable_hash.to_json
      end

      # from top subscription. stable.
      def enter_from_subscription
        @space = Space.find_by(id: params[:space_id])
        @space.comments.update_all(confirmation: true)
        if @space.tv?
          serializer = TvSpaceSerializer.new(@space)
        elsif @space.mv?
          serializer = MvSpaceSerializer.new(@space)
        end
        render json: serializer.serializable_hash.to_json
      end
    end
  end
end