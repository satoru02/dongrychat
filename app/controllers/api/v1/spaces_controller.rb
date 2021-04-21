module Api
  module V1
    class SpacesController < ApplicationController
      before_action :authorize_access_request!, only: [:index, :enter, :enter_from_subscription]
      before_action :set_space, only: [:enter_from_subscription]
      require 'will_paginate/array'

      def index
        @spaces = current_user.spaces.order_by_comments(current_user).paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = set_home_space_serializer(@spaces)
        render_json(serializer)
      end

      def trend
        @spaces = Space.get_trend(params).paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = set_trend_space_serializer(@spaces)
        render_json(serializer)
      end

      def enter
        if params[:media] === 'mv'
          @space = Space.create_or_search_mv(mv_space_params, current_user)
        elsif params[:media] === 'tv'
          @space = Space.create_or_search_tv(tv_space_params, current_user)
        end

        @condition = current_user.subscribed?(@space.id)
        serializer = set_space_serializer(@space, @condition, params[:media])
        render_json(serializer)
      end

      def enter_from_subscription
        @condition = current_user.subscribed?(@space.id)
        serializer = set_space_serializer(@space, @condition, params[:media])
        render_json(serializer)
      end

      private

        def set_home_space_serializer(spaces)
          HomeSpaceSerializer.new(spaces, current_user_params)
        end

        def set_trend_space_serializer(spaces)
          TrendSpaceSerializer.new(spaces)
        end

        def set_space_serializer(space, condition, media)
          SpaceSerializer.new(space, enter_params(condition, media))
        end

        def set_space
          @space = Space.find_by(id: params[:space_id])
        end

        def mv_space_params
          params.permit(:name, :media, :image_path, :tmdb_mv_id, :overview, :page, :per_page, :tag_list => [])
        end

        def tv_space_params
          params.permit(:name, :season, :episode, :episode_title, :media, :tmdb_comp_id, :tmdb_tv_id, :image_path, :overview, :page, :per_page, :tag_list => [])
        end

        def current_user_params
          { params: { current_user: current_user } }
        end

        def enter_params(condition, media)
          { params: { condition: condition, media: media } }
        end
    end
  end
end