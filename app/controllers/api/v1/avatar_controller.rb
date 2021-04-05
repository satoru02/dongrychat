module Api
  module V1
    class AvatarController < ApplicationController

      def presigned_url
        filename = params[:filename]
        filetype = params[:filetype]

        post = S3_BUCKET.presigned_post(
          key: "avatar/#{filename}",
          acl: 'public-read',
          content_type: filetype,
          metadata: {
            'original-filename' => filename
          }
        )

        render json: {url: post.url, fields: post.fields}
      end
    end
  end
end