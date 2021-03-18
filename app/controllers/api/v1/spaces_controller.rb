module Api
  module V1
    class SpacesController < ApplicationController
      before_action :authorize_access_request!

      def enter
        if params[:media] === 'mv'
          @space = Space.create_or_search_mv(params.permit(:name, :season, :episode, :media), current_user)
          serializer = MvSpaceSerializer.new(@space)
        elsif params[:media] === 'tv'
          @space = Space.create_or_search_tv(params.permit(:name, :season, :episode, :media), current_user)
          serializer = TvSpaceSerializer.new(@space)
        end
        render json: serializer.serializable_hash.to_json
      end
    end
  end
end