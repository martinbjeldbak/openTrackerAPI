module Api
  module V1
    class LapsController < ApplicationController
      load_resource :session
      load_resource through: :session
      #load_and_authorize_resource :session
      #load_and_authorize_resource through: :session

      # lap_nr, session

      before_filter :ensure_session_auth

      def index

      end

      def create

      end

      def update

      end

      private

      def laps_params
        params.require(:lap).permit(:lap_nr, :session_id)
      end

      # http://railscasts.com/episodes/352-securing-an-api
      # Require a session token to do anything with laps
      def ensure_session_auth
        authenticate_or_request_with_http_token do |token, options|
          @session.key.key == token
          #Key.exists?(key: token)
        end
      end
    end
  end
end