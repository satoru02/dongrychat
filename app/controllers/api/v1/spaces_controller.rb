module Api
  module V1
    class SpacesController < ApplicationController
      before_action :authorize_access_request!
      require 'will_paginate/array'

      def index
        # fix -> scope
        @spaces = current_user.spaces.includes(:comments, :users).sort_by{|space| [-space.unread_comments(current_user).length]}.paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = CaptionSpaceSerializer.new(@spaces, {params: {current_user: current_user}})
        render json: serializer.serializable_hash.to_json
      end

      def trend
        @spaces = Space.includes(:users).getTrend(params).paginate(:page => params[:page], :per_page => params[:per_page])
        serializer = CaptionSpaceSerializer.new(@spaces, {params: {current_user: current_user}})
        render json: serializer.serializable_hash.to_json
      end

      # from space component. unstable.
      def enter
        if params[:media] === 'mv'
          @space = Space.create_or_search_mv(params.permit(:name, :media, :image_path, :tmdb_mv_id, :page, :per_page), current_user)
          # @space = Space.create_or_search_mv(movie_space_params, current_user)
          @media = 'mv'
        elsif params[:media] === 'tv'
          @space = Space.create_or_search_tv(params.permit(:name, :season, :episode, :episode_title, :media, :tmdb_tv_id, :image_path, :page, :per_page), current_user)
          # @space = Space.create_or_search_mv(tv_space_params, current_user)
          @media = 'tv'
        end

        @condition = current_user.subscribed?(@space.id)

        if @space.comments.exists?
          @comments = @space.comments.includes(:user).order("created_at ASC").pager(page: params[:page], per: params[:per_page])
          serializer = CommentSerializer.new(@comments, {params: {condition: @condition, media: @media}})
        else
          serializer = SpaceSerializer.new(@space, {params: {condition: @condition, media: @media}})
        end
        render json: serializer.serializable_hash.to_json
      end

      # from top subscription. stable.
      def enter_from_subscription
        @space = Space.find_by(id: params[:space_id])
        @condition = current_user.subscribed?(@space.id)

        if @space.comments.exists?
          @space.comments.where(confirmation: false).update_all(confirmation: true)
          @comments = @space.comments.includes(:user).order("created_at ASC").pager(page: params[:page], per: params[:per_page])
          serializer = CommentSerializer.new(@comments, {params: {condition: @condition, media: params[:media]}})
        else
          serializer = SpaceSerializer.new(@space, {params: {condition: @condition, media: params[:media]}})
        end
        render json: serializer.serializable_hash.to_json
      end

      private

        def movie_space_params
          params.permit(:name, :media, :image_path, :tmdb_mv_id, :page, :per_page)
        end

        def tv_space_params
          params.permit(:name, :season, :episode, :episode_title, :media, :tmdb_tv_id, :image_path, :page, :per_page)
        end
    end
  end
end