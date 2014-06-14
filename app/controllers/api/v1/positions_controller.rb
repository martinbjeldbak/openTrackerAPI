module Api
  module V1
    class LapsController < ApplicationController
      load_resource :session
      load_resource through: :lap

      before_filter ->(c) { c.ensure_session_auth @session}

      private

      def laps_params
        params.require(:position).permit(:x, :y, :z)
      end

      # http://railscasts.com/episodes/352-securing-an-api
      # Require a session token to do anything with laps
      def ensure_session_auth
        authenticate_or_request_with_http_token do |token, options|
          @lap.session.key.key == token
          #Key.exists?(key: token)
        end
      end

    end
  end
end