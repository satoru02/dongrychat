module Api
  module V1
    class SpacesController < ApplicationController
      before_action :authorize_access_request!

      def index
        @user = User.find_by(id: params[:user_id])
        @spaces = @user.spaces
        # fix -> add MvSpaceSerializer
        serializer = TvSpaceSerializer.new(@spaces)
        render json: serializer.serializable_hash.to_json
      end

      # for search
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

      # for subscription
      def enter_from_subscription
      end
    end
  end
end